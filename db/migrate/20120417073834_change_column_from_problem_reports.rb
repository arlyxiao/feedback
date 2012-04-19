class ChangeColumnFromProblemReports < ActiveRecord::Migration
  def change
    rename_column :problem_reports, :problem_report_id, :problem_type_id
  end
end
