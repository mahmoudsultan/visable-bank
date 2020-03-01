# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BankAccount, type: :model do
  it { is_expected.to validate_uniqueness_of :account_number }
end
