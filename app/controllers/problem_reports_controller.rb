class ProblemReportsController < ApplicationController
  before_filter :valid_simple_captcha,:only=>[:create]
  def valid_simple_captcha
    if !logged_in? && !simple_captcha_valid?
      flash[:error] = "验证码输入错误"
      redirect_to "/problem_reports/new"
    end
  end

  def index
    if current_user.is_admin?
      _index_admin
    else
      _index_common_user
    end
    # 问题类型
    @problem_types = ProblemType.all
  end

  def _index_common_user
    unless params[:type].blank?
      @reports = current_user.problem_reports.find_all_by_problem_type_id(params[:problem_type_id])
    else
      @reports = current_user.problem_reports
    end
  end

  def _index_admin
    unless params[:type].blank?
      @reports = ProblemReport.find_all_by_problem_type_id(params[:problem_type_id])
    else
      @reports = ProblemReport.all
    end
  end
  
  def new
    @problem_report = ProblemReport.new
    @problem_types = ProblemType.all
    @problem_fields = ProblemField.all

    if logged_in?
      @reports = current_user.problem_reports
    else
      render :template => 'problem_reports/anonymous_new'
    end
  end

  def _create_build_problem_report
    if logged_in?
      problem_report = current_user.problem_reports.build(params[:problem_report])
    else
      problem_report = ProblemReport.new(params[:problem_report])
    end
    problem_report.ip = request.remote_ip
    # 关联附件
    problem_report.attachement_ids = params[:attachements]

    problem_report    
  end

  def create
    @problem_report = _create_build_problem_report

    if !@problem_report.save
      error = @problem_report.errors.first
      flash[:error] = "#{error[0]} #{error[1]}"
      return redirect_to "/problem_reports/new"
    end
    
    redirect_to new_problem_report_path
  end

  def reply
    report = ProblemReport.find(params[:report_id])
    report.admin_reply = params[:admin_reply]
    report.save
    
    redirect_to problem_reports_path
  end
  
  def upload_attachement
    report = ProblemReportAttachement.create( params[:attachement] )
    render :text => report.id
    # render :text => 1
  end

end
