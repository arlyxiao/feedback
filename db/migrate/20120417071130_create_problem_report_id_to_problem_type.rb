class CreateProblemReportIdToProblemType < ActiveRecord::Migration
  def change
    add_column :problem_reports, :problem_report_id, :integer
  end
end
