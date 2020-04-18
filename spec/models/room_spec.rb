require 'rails_helper'

# create_table "rooms", force: :cascade do |t|
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end

RSpec.describe Room, type: :model do
  before do
    @room = FactoryBot.create(:room)
  end

  it "作成されるかの確認" do
    expect(@room).to be_valid
  end
end
