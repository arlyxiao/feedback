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
      @problem_report.save
    else
      @problem_report = ProblemReport.new
      if @problem_report.valid_with_captcha?
        @problem_report.email = params[:email]
        @problem_report.content= params[:content]
        @problem_report.ip = request.remote_ip
        @problem_report.save
      end
    end
    redirect_to new_problem_report_path
  end

  def reply
  end

end
