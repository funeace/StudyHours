class CreateStudyLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :study_logs do |t|
      t.integer :user_id,null: false
      t.string :memo
      t.date :working_date,null: false
      t.timestamps
    end
    add_index :study_logs, :user_id
  end
end
