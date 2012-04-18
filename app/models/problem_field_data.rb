class ProblemFieldData < ActiveRecord::Base
  # --- 模型关联
  belongs_to :problem_report, :class_name => 'ProblemReport', :foreign_key => 'problem_report_id'
  belongs_to :problem_field, :class_name => 'ProblemField', :foreign_key => 'problem_field_id'
end
