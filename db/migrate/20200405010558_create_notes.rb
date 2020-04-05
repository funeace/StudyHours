class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.integer :user_id, null:false
      t.string :title, null:false
      t.text :body, null:false
      t.timestamps
    end
    add_index :notes, :user_id
    add_index :notes, :title
  end
end