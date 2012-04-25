class RemoveConfigFileFromProblemTypes < ActiveRecord::Migration
  def change
    remove_column :problem_types, :config_file
  end
end
