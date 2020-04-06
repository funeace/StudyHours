class ProfileImageIdToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :profile_image_id, :string
  end

  def down
    remove_column :users, :profile_image_id, :string
  end
end
