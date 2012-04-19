class CreateProblemFieldData < ActiveRecord::Migration
  def change
    create_table :problem_field_data do |t|
      t.integer :problem_report_id
      t.integer :problem_field_id
      t.string :content
      
      t.timestamps
    end
  end
end
