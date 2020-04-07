class CreateStudyLogDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :study_log_details do |t|
      t.integer :study_log_id, null:false
      t.integer :hour, null: false,default: 0
      t.integer :min, null: false,default: 0
      t.timestamps
    end
    add_index :study_log_details, :study_log_id
  end
end