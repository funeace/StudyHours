class ChangeDataCommentToStudyLogComment < ActiveRecord::Migration[5.2]
  def up
    change_column :study_log_comments, :comment, :string, null: false
  end

  def down
    change_column :study_log_comments, :comment, :integer, null: false
  end

end