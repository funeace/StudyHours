class AddColumnToStudyLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :study_logs, :hour,:integer,null: false,default: 0
    add_column :study_logs, :minute,:integer , null: false, default: 0
  end
end