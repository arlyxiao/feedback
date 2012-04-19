class CreateProblemFields < ActiveRecord::Migration
  def change
    create_table :problem_fields do |t|
      t.integer :creator_id
      t.string :name

      t.timestamps
    end
  end
end
