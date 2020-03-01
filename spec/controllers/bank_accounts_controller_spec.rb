# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BankAccountsController, type: :controller do
  describe 'GET show' do
    context 'when BankAccount exists' do
      let!(:bank_account) { FactoryBot.create :bank_account }

      before do
        # Create 10 Transactions
        second_bank_account = FactoryBot.create :bank_account, balance: 100
        10.times do
          Transaction.create(to_account: bank_account, from_account: second_bank_account, amount: 10)
        end

        get :show, params: { id: bank_account.id }
      end

      it 'returns 200' do
        expect(response).to have_http_status :ok
      end

      it 'returns correct BankAccount' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['id']).to eql bank_account.id
      end

      it 'returns the last 10 Transactions for this BankAccount' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['transactions'].length).to be 10
      end
    end

    context 'when BankAccount does not exist' do
      before do
        non_existant_bank_account_id = if BankAccount.any?
                                         BankAccount.last.id + 1
                                       else
                                         1
                                       end

        get :show, params: { id: non_existant_bank_account_id }
      end

      it 'returns 404' do
        expect(response).to have_http_status :not_found
      end
    end
  end
end
