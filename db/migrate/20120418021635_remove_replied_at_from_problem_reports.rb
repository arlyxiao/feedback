class RemoveRepliedAtFromProblemReports < ActiveRecord::Migration
  def change
    remove_column :problem_reports, :replied_at
  end
end
