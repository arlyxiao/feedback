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
          problem_field = ProblemField.create(
            :creator => current_user, 
            :name  => field, 
            :field_type => type,
            :problem_type_id => params[:problem_field][:problem_type_id]
          )
          
          # 保存表单类型值
          case type
          when 'select-field'
            
            unless params[:select_options].blank?
              params[:select_options].each do |option| 
                ProblemFieldType.create(:problem_field => problem_field, :title => option)
              end
            end
            
          else
            
          end
          
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
