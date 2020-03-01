FactoryBot.define do
  factory :transaction do
    from_account { nil }
    to_account { nil }
    amount { "9.99" }
  end
end
