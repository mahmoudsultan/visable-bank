# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it { is_expected.to validate_presence_of :to_account }
  it { is_expected.to validate_presence_of :from_account }

  it { is_expected.to belong_to(:to_account).class_name('BankAccount') }
  it { is_expected.to belong_to(:from_account).class_name('BankAccount') }
end
