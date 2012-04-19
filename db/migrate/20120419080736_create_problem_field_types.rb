class CreateProblemFieldTypes < ActiveRecord::Migration
  def change
    create_table :problem_field_types do |t|
      t.integer :problem_field_id
      t.string :title
      
      t.timestamps
    end
  end
end
