class ProblemFieldType < ActiveRecord::Base
  # --- 模型关联
  belongs_to :problem_field, :class_name => 'ProblemField', :foreign_key => 'problem_field_id'
end
