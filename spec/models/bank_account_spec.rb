require 'rails_helper'

RSpec.describe BankAccount, type: :model do
  it { should validate_uniqueness_of :account_number }
end
