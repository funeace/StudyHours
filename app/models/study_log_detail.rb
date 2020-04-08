class StudyLogDetail < ApplicationRecord
  belongs_to :study_log
  # tagsテーブルとの関連付けを行う defaultは tag_list
  acts_as_taggable
end
