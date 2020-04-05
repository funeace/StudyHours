class CreateRecordDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :record_details do |t|
      t.integer :record_id, null:false
      t.integer :hour, null:false
      t.integer :min, null:false
      t.timestamps
    end
    add_index :record_details, :record_id
  end
end
