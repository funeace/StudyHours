class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :user_id, null: false
      t.integer :visit_id, null: false
      t.integer :study_log_id
      t.integer :study_log_comment_id
      t.integer :note_id
      t.integer :note_comment_id
      t.string :action,default: "", null:false
      t.boolean :checked, default: false, null: false
      t.timestamps
    end
  end
end
