class ProblemReportsController < ApplicationController
  def index
    if current_user.is_admin?
      unless params[:type].blank?
        @reports = ProblemReport.find_all_by_problem_type_id(params[:problem_type_id])
      else
        @reports = ProblemReport.all
      end
      
    else
      unless params[:type].blank?
        @reports = current_user.problem_reports.find_all_by_problem_type_id(params[:problem_type_id])
      else
        @reports = current_user.problem_reports
      end
      
    end
    
    # 问题类型
    @problem_types = ProblemType.all
  end
  
  def new
    @problem_report = ProblemReport.new
    @problem_types = ProblemType.all

    if logged_in?
      @reports = current_user.problem_reports
    else
      render :template => 'problem_reports/anonymous_new'
    end
  end

  def create
    params[:problem_report][:ip] = request.remote_ip
    if logged_in?
      @problem_report = current_user.problem_reports.build(params[:problem_report])
    else
      @problem_report = ProblemReport.new
      if simple_captcha_valid?
        @problem_report.email = params[:email]
        @problem_report.content= params[:problem_report][:content]
        @problem_report.ip = request.remote_ip
      end
    end
    
    unless @problem_report.save
      error = @problem_report.errors.first
      flash[:error] = "#{error[0]} #{error[1]}"
    else
      # 关联上传表单
      attachements = params[:attachements]
      unless attachements.blank?
        attachements.each do |attachement_id|
          problem_report_attachement = ProblemReportAttachement.find(attachement_id)
          problem_report_attachement.problem_report = @problem_report
          problem_report_attachement.creator = current_user
          problem_report_attachement.save
        end
        
        # 生成 zip 包
        @problem_report.build_attachements_zip(current_user)
      end
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
    report = ProblemReportAttachement.create( params[:problem_report_attachement] )
    render :text => report.id
    # render :text => 1
  end

end
