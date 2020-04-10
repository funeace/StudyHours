class RemoveNameToRoom < ActiveRecord::Migration[5.2]
  def change
    remove_column :rooms, :room_name, :string
  end
end
