class ProblemReportsController < ApplicationController
  def index
  end
  
  def new
    @problem_report = ProblemReport.new

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
  end

end
