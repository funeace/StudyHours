class AddWorkingDateToRecords < ActiveRecord::Migration[5.2]
  def up
    add_column :records, :working_date, :date
    change_column :records, :working_date, :date, null: false
  end

  def down
    remove_column :records, :working_date, :date
  end
end
