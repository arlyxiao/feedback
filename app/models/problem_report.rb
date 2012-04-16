class ProblemReport < ActiveRecord::Base
  # --- 模型关联
   
  # --- 校验方法
  
  # --- 给其他类扩展的方法
  module UserMethods
    def self.included(base)
      # base.has_many :short_messages, :foreign_key => :sender_id

      base.send(:include, InstanceMethods)
    end
    
    module InstanceMethods

    end
  end
end
