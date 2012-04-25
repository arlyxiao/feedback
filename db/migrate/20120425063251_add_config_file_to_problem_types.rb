class AddConfigFileToProblemTypes < ActiveRecord::Migration
  def change
    add_column :problem_types, :config_file, :string
  end
end
