require 'zip/zip'
class ProblemReport < ActiveRecord::Base
  # 验证码
  apply_simple_captcha :message => "验证码输入有误", :add_to_base => true
  
  # --- 模型关联
  belongs_to :creator, :class_name => 'User', :foreign_key => :creator_id
  belongs_to :problem_type, :class_name => 'ProblemType'
  has_many :problem_report_attachements, :class_name => 'ProblemReportAttachement', :foreign_key => :report_id
  has_many :problem_field_data
  
  accepts_nested_attributes_for :problem_report_attachements
  accepts_nested_attributes_for :problem_field_data
  
  # --- 校验方法
  validates :content, :presence => true
  
  # 生成的附件压缩包
  def build_attachements_zip(user)
    zipfile_name = "/web/2012/problem_report_attachements/problem_report#{user.id}_#{self.id}.zip"
    Zip::ZipFile.open(zipfile_name, Zip::ZipFile::CREATE) do |zipfile|
      self.problem_report_attachements.each do |file|
        unless zipfile.find_entry(file.attachement_file_name)
          zipfile.add(file.attachement_file_name, file.attachement.path)
        end
      end
    end
  end
  

  # --- 给其他类扩展的方法
  module UserMethods
    def self.included(base)
      base.has_many :problem_reports, :foreign_key => :creator_id

      base.send(:include, InstanceMethods)
    end
    
    module InstanceMethods

    end
  end
end
