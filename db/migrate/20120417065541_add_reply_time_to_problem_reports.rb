class AddReplyTimeToProblemReports < ActiveRecord::Migration
  def change
    add_column :problem_reports, :replied_at, :datetime
  end
end
