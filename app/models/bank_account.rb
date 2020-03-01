class BankAccount < ApplicationRecord
  validates :account_number, uniqueness: true
end
