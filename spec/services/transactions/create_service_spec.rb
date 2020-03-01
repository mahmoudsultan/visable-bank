# frozen_string_literal: true

require 'rails_helper'

module Transactions
  RSpec.describe CreateService do
    describe '#execute' do
      let(:amount) { 100 }
      let!(:to_account) { FactoryBot.create :bank_account, balance: 0 }
      let!(:from_account) { FactoryBot.create :bank_account, balance: 100 }

      before do
        described_class.new(to_account, from_account, amount).execute
        to_account.reload
        from_account.reload
      end

      it 'creates a new transaction with correct values' do
        expect(to_account.transactions.last.from_account).to eql from_account
      end

      it 'decreases balance in from_account by amount' do
        expect(to_account.balance).to eql amount
      end

      it 'increases balance in to_account by amount' do
        expect(from_account.balance).to be 0
      end
    end
  end
end
