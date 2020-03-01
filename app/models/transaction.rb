# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :from_account, class_name: 'BankAccount'
  belongs_to :to_account, class_name: 'BankAccount'

  validates :from_account, presence: true
  validates :to_account, presence: true

  validates :amount, numericality: { greater_than: 0 }
end
