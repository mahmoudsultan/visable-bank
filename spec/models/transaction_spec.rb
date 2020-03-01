# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it { should validate_presence_of :to_account }
  it { should validate_presence_of :from_account }

  it { should validate_numericality_of(:amount).is_greater_than(0) }

  it { should belong_to(:to_account).class_name('BankAccount') }
  it { should belong_to(:from_account).class_name('BankAccount') }
end
