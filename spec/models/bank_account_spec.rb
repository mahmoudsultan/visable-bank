# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BankAccount, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_uniqueness_of :account_number }
  end

  describe 'Transactions' do
    context 'when there\'s transaction from this account' do
      let!(:bank_account) { FactoryBot.create :bank_account }

      before do
        another_bank_account = FactoryBot.create :bank_account
        FactoryBot.create(:transaction,
                          from_account: bank_account,
                          to_account: another_bank_account)
      end

      it 'returns one transaction' do
        expect(bank_account.transactions.length).to be 1
      end
    end

    context 'when there\'s transaction to this account' do
      let!(:bank_account) { FactoryBot.create :bank_account }

      before do
        another_bank_account = FactoryBot.create :bank_account
        FactoryBot.create(:transaction,
                          from_account: another_bank_account,
                          to_account: bank_account)
      end

      it 'returns one transaction' do
        expect(bank_account.transactions.length).to be 1
      end
    end

    context 'when there are one transaction from this account and another to it' do
      let!(:first_bank_account) { FactoryBot.create :bank_account }
      let!(:second_bank_account) { FactoryBot.create :bank_account }

      let!(:first_transaction) do
        FactoryBot.create(:transaction,
                          from_account: first_bank_account,
                          to_account: second_bank_account)
      end
      let!(:second_transaction) do
        FactoryBot.create(:transaction,
                          from_account: second_bank_account,
                          to_account: first_bank_account)
      end

      it 'returns 2 transactions' do
        expect(first_bank_account.transactions.length).to be 2
      end

      it 'returns transactions sorted by createdAt' do
        expect([first_bank_account.transactions.first,
                first_bank_account.transactions.second]).to eql [first_transaction, second_transaction]
      end
    end
  end
end
