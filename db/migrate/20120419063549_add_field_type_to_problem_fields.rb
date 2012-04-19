class AddFieldTypeToProblemFields < ActiveRecord::Migration
  def change
    add_column :problem_fields, :field_type, :string
  end
end
