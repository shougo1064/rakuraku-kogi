FactoryBot.define do
  factory :homework do
    title { "MyString" }
    body { "MyText" }
    action { "2021-06-22 19:47:59" }
    deadline { "2021-06-22 19:47:59" }
    user { nil }
  end
end
