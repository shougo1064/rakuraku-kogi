FactoryBot.define do
  factory :message do
    title { "MyString" }
    body { "MyText" }
    user { nil }
  end
end
