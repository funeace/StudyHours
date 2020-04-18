require 'rails_helper'

# create_table "relationships", force: :cascade do |t|
#   t.integer "user_id", null: false
#   t.integer "follow_id", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["follow_id"], name: "index_relationships_on_follow_id"
#   t.index ["user_id", "follow_id"], name: "index_relationships_on_user_id_and_follow_id", unique: true
#   t.index ["user_id"], name: "index_relationships_on_user_id"
# end

RSpec.describe Relationship, type: :model do
  before do
    user = FactoryBot.create(:user)
    other_user = FactoryBot.create(:other_user)
    @relationship = Relationship.new(user_id: user.id,follow_id: other_user.id)
  end

  it "必要項目が存在していれば有効" do
    expect(@relationship).to be_valid
  end

  it "user_idが存在していなかったら無効" do
    @relationship.user_id = ""
    expect(@relationship).not_to be_valid
  end

  it "follow_idが存在していなかったら無効" do
    @relationship.follow_id = ""
    expect(@relationship).not_to be_valid
  end
  
end
