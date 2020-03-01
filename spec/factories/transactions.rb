# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    association :from_account, factory: :bank_accounts
    association :to_account, factory: :bank_accounts
    amount { 9.99 }
  end
end
