# frozen_string_literal: true

module Transactions
  class CreateService
    def initialize(to_account, from_account, amount)
      @to_account = to_account
      @from_account = from_account
      @amount = amount
    end

    def execute
      BankAccount.transaction do
        # Acquire locks on the two Bank Accounts
        BankAccount.lock.find(@to_account.id, @from_account.id)

        # Create a new transactions
        Transaction.create(to_account: @to_account, from_account: @from_account, amount: @amount)

        # Move amount from the from_account to the to_account
        @to_account.balance += @amount
        @from_account.balance -= @amount

        @from_account.save!
        @to_account.save!
      end
    end
  end
end
