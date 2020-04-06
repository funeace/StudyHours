class ChangeTimeDefaultOnRecordDetail < ActiveRecord::Migration[5.2]
  def change
    change_column_default :record_details, :hour, from: nil, to: 0
    change_column_default :record_details, :min, from: nil, to: 0
  end
end

