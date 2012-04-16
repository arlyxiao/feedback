class CreateProblemReports < ActiveRecord::Migration
  def change
    create_table :problem_reports do |t|
      t.integer :creator_id
      t.string :email
      t.text :content
      t.text :admin_reply
      t.string :ip

      t.timestamps
    end
  end
end
