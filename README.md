# VisableBank

## Implemented Endpoints:

```
POST /transactions
    Body:
    {
        to_account,
        from_account,
        amount
    }
    Response:
        201: Transaction created
        422: One account is missing or amount is 0 or invalid

GET /bank_accounts/:id
    Response:
        200: Account and last 10 transactions
        404: Account not found
```

## Run Project
```
bundle install
rails s
```

Testing:
```
bundle exec rspec
```
**Tests covers multiple usage examples.**

Linting:
```
bundle exec rubocop
```

## Notes
### Transactions Fetching
To fetch transactions for a BankAccount I'm using a custom where query instead of normal `has_many` association, to return transactions where either `to_account` or `from_account` equals to the requested BankAccount.

This means however that in case of implementing a listing service and including transactions for each this will result in O(n+1) query; so this needs to be handled in that case.

### Using BankAccount ID
For simplicity and time I've used BankAccount Ids when referencing and creating a transaction.

A refactor would be to use BankAccount `account_number` in create transaction endpoint, this would make more sense in the application.

### Lock Choice:
I've choosed Pessimistic Locks on the two BankAccounts included in creating a transaction instead of an optimistic locks to avoid unnecessarily fails and handling retrials.

Also used `BankAccount.lock.find(@to_account.id, @from_account.id)` specifically to avoid deadlocks for the case:

```
Client 1 .......... Client 2

lock(1)  ...................
.................... lock(2)
lock(2) Blocked.............
.................... lock(1) Blocked
```

`BankAccount.lock.find(@to_account.id, @from_account.id)` generates a SQL query like:

```
SELECT `bank_accounts`.* FROM `bank_accounts` WHERE `bank_accounts`.`id` IN (1, 2) FOR UPDATE
```

So only one will get the lock on both first.

### No 0 amount Transactions are permitted