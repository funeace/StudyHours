class StudyLogDetail < ApplicationRecord
  belongs_to :study_log
  # tagsテーブルとの関連付けを行う defaultは tag_list
  acts_as_taggable

  # 学習記録のカラムhourとminがそれぞれ0のときにエラーを返す
  validates_with StudyTimesCheck
  validates :hour,presence: true
  validates :min,presence: true
end
