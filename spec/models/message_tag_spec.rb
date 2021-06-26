# == Schema Information
#
# Table name: message_tags
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  message_id :bigint           not null
#  tag_id     :bigint           not null
#
# Indexes
#
#  index_message_tags_on_message_id  (message_id)
#  index_message_tags_on_tag_id      (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (message_id => messages.id)
#  fk_rails_...  (tag_id => tags.id)
#
require "rails_helper"

RSpec.describe MessageTag, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
