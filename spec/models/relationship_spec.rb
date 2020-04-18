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
  pending "add some examples to (or delete) #{__FILE__}"
end
