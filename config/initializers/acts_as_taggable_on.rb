# タグの大文字と小文字を区別しない
ActsAsTaggableOn.strict_case_match = false

# タグ新規登録時のカラーコードを返す
def tag_color
  color = [*126..255]
  r = color.sample
  g = color.sample
  b = color.sample
  # 16進数に変換
  return "##{"%02x"%r}#{"%02x"%g}#{"%02x"%b}"
end

# tagのカラーコードがnilのものにカラーコードを付与
def grant_color_code
  ActsAsTaggableOn::Tag.where(color_code: nil).each do |tag|
    tag.update(color_code: tag_color)  
  end
end