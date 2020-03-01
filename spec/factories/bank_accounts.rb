# frozen_string_literal: true

FactoryBot.define do
  factory :bank_account do
    sequence(:account_number) { |n| "100-#{n}-001" }
    balance { 0 }
  end
end
