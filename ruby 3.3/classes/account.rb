class Account
  protected attr_accessor :balance
  # Because balance is protected, it’s available only within Account objects.

  def initialize(balance)
    @balance = balance
  end

  def greater_balance_than?(other_account)
    @balance > other_account.balance
  end

end

class Transaction
  def initialize(account_a, account_b)
    @account_a = account_a
    @account_b = account_b
  end

  def transfer(amount)
    debit(@account_a, amount)
    credit(@account_b, amount)
  end

  private def debit(account, amount)
    account.balance -= amount
  end

  private def credit(account, amount)
    account.balance += amount
  end
end

savings = Account.new(100)
checking = Account.new(200)

transaction = Transaction.new(checking, savings)
transaction.transfer(50)

puts "savings balance: #{savings.balance}"

# Protected access is used when objects need to access the internal state of other objects of the same class.
# 