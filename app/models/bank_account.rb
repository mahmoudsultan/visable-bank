# frozen_string_literal: true

class BankAccount < ApplicationRecord
  validates :account_number, uniqueness: true

  def transactions
    Transaction.where('to_account_id = ? OR from_account_id = ?', id, id)
  end
end
