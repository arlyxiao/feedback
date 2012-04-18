class ProblemFieldsController < ApplicationController
  def new
    @problem_field = ProblemField.new
    @problem_fields = ProblemField.all
  end
  
  def create
    unless params[:problem_fields].blank?
      params[:problem_fields].each do |field|
        unless field.blank?
          ProblemField.create(:creator => current_user, :name  => field)
        end
      end
    end
    redirect_to :back
  end
  
  def destroy
    @problem_field = ProblemField.find(params[:id])
    @problem_field.destroy
    redirect_to :back
  end
  
end
