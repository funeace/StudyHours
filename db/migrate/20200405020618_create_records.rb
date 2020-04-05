class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.integer :user_id, null:false
      t.string :memo
      t.timestamps
    end
    add_index :records, :user_id
  end
end
