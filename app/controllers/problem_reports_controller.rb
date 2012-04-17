class ProblemReportsController < ApplicationController
  def index
    if current_user.is_admin
      @reports = ProblemReport.all
    else
      @reports = current_user.problem_reports
    end
    
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
    end
    
    redirect_to new_problem_report_path
  end

  def reply
    report = ProblemReport.find(params[:report_id])
    report.admin_reply = params[:admin_reply]
    report.replied_at = Time.now
    report.save
    
    redirect_to problem_reports_path
  end

end
