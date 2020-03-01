FIRST_BANK_ACCOUNT_NUMBER = '100-001-010'
SECOND_BANK_ACCOUNT_NUMBER = '101-010-011'
TRANSACTIONS_COUNT_TO_ACCOUNT = 10

first_bank_account = BankAccount.create_with(balance: 100)
                                .find_or_create_by(account_number: FIRST_BANK_ACCOUNT_NUMBER)


second_bank_account = BankAccount.create_with(balance: 100)
                                 .find_or_create_by(account_number: SECOND_BANK_ACCOUNT_NUMBER)

first_bank_account.transactions.delete_all
second_bank_account.transactions.delete_all

TRANSACTIONS_COUNT_TO_ACCOUNT.times do
  Transaction.create(to_account: first_bank_account, from_account: second_bank_account, amount: rand(1...1000))
  Transaction.create(to_account: second_bank_account, from_account: first_bank_account, amount: rand(1...1000))
end
