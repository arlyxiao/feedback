class ProblemField < ActiveRecord::Base
  # --- 模型关联
  belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'
  has_many :problem_field_data
  
  # --- 校验方法
  
  
  # --- 给其他类扩展的方法
  module UserMethods
    def self.included(base)
      base.has_many :problem_fields, :foreign_key => :creator_id

      base.send(:include, InstanceMethods)
    end
    
    module InstanceMethods

    end
  end
  
end
