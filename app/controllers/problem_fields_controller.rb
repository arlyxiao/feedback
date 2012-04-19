class ProblemFieldsController < ApplicationController
  def new
    @problem_field = ProblemField.new
    @problem_fields = ProblemField.all
  end
  
  def create
    unless params[:field_types].blank?
      params[:field_types].each do |type|
        unless type.blank?
          field = params[:problem_fields][type]
          ProblemField.create(:creator => current_user, :name  => field, :field_type => type)
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
