# frozen_string_literal: true

class BankAccount < ApplicationRecord
  validates :account_number, uniqueness: true
end
