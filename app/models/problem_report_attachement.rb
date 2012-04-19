class ProblemReportAttachement < ActiveRecord::Base
  # --- 模型关联
  belongs_to :problem_report, :class_name => 'ProblemReport', :foreign_key => 'report_id'
  belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'
  
  # 上传提交物路径
  has_attached_file :attachement, :path => "/web/2012/:class/:attachment/:id/:style/:basename.:extension"
end
