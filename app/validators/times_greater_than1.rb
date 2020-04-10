class TimesGreaterThan1 < ActiveModel::Validator
  # 学習記録が0のときにエラーを返す
  def validate(record)
    hour = record.hour
    min = record.min
    return unless (hour == 0 && min == 0)
    record.errors[:base] << '学習時間を入力してください'
  end
end