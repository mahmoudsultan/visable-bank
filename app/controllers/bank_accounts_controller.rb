# frozen_string_literal: true

class BankAccountsController < ApplicationController
  before_action :set_bank_account, only: %i[show]

  def show
    render json: BankAccountBlueprint.render(@bank_account, view: :extended)
  end

  private

  def set_bank_account
    @bank_account = BankAccount.find params[:id] || params[:bank_account_id]
  end
end
