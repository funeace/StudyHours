class CreateStudyLogComments < ActiveRecord::Migration[5.2]
  def change
    create_table :study_log_comments do |t|
      t.integer :study_log_id,null:false
      t.integer :user_id,null:false
      t.integer :comment,null:false
      t.timestamps
    end
  end
end
