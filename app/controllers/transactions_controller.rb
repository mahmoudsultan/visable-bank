# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :set_to_and_from_accounts, only: %i[create]

  def create
    if @to_account.nil? || @from_account.nil?
      render status: :unprocessable_entity
    else
      created_transaction = Transactions::CreateService.new(@to_account,
                                                            @from_account,
                                                            transaction_params['amount'].to_i).execute

      render json: { transaction: created_transaction }, status: :created
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(%i[to_account_id from_account_id amount])
  end

  def set_to_and_from_accounts
    @to_account = BankAccount.find_by id: transaction_params['to_account_id']
    @from_account = BankAccount.find_by id: transaction_params['from_account_id']
  end
end
