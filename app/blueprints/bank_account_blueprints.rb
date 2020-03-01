# frozen_string_literal: true

class BankAccountBlueprint < Blueprinter::Base
  view :normal do
    fields :id, :balance, :account_number
  end

  view :extended do
    include_view :normal
    field :transactions do |bank_account|
      # TODO: refactor to use TransactionBlueprint instead
      bank_account.transactions.limit(10).to_a.map(&:to_json)
    end
  end
end
