# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  describe 'POST #create' do
    let!(:first_bank_account) { FactoryBot.create :bank_account }
    let!(:second_bank_account) { FactoryBot.create :bank_account }

    context 'when both accounts exists' do
      let(:valid_transaction_params) do
        FactoryBot.attributes_for(:transaction).merge(
          to_account_id: first_bank_account,
          from_account_id: second_bank_account
        )
      end

      it 'creates a new transaction' do
        expect do
          post :create, params: { transaction: valid_transaction_params }
        end.to change(Transaction, :count).by(1)
      end

      it 'returns 201' do
        post :create, params: { transaction: valid_transaction_params }
        expect(response).to have_http_status :created
      end
    end

    context 'when an account does not exist' do
      let(:invalid_transaction_params) do
        FactoryBot.attributes_for(:transaction).merge(
          to_account_id: first_bank_account,
          from_account_id: BankAccount.last.id + 1
        )
      end

      before do
        post :create, params: { transaction: invalid_transaction_params }
      end

      it 'returns 422' do
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end
end
