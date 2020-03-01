# frozen_string_literal: true

module Transactions
  class CreateService
    def initialize(to_account, from_account, amount)
      @to_account = to_account
      @from_account = from_account
      @amount = amount
    end

    def execute
      # Create a new transactions
      Transaction.create(to_account: @to_account, from_account: @from_account, amount: @amount)

      # Move amount from the from_account to the to_account
      @to_account.update(balance: @to_account.balance + @amount)
      @from_account.update(balance: @from_account.balance - @amount)
    end
  end
end
