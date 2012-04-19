class CreateProblemTypes < ActiveRecord::Migration
  def change
    unless ActiveRecord::Base.connection.table_exists? 'problem_types' then
      create_table :problem_types do |t|
        t.integer :creator_id
        t.string :name
  
        t.timestamps
      end
    end
  end
end
