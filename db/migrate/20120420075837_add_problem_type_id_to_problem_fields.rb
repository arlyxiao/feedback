class AddProblemTypeIdToProblemFields < ActiveRecord::Migration
  def change
    add_column :problem_fields, :problem_type_id, :integer
  end
end
