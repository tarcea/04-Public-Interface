# This is how you define your own custom exception classes
class DepositError < StandardError
end

class BankAccount
  attr_reader :name, :balance
  # Contract for the BankAccount class
  # - you can access full owner's name and balance, but partial IBAN
  # - you cannot access full IBAN
  # - you can print partial account info
  # - you can print transactions only with a password
  # - you can withdraw or deposit money
  # - You can see the balance of the account (through the balance variable)

  MIN_DEPOSIT = 100

  def initialize(name, iban, initial_deposit, password)
    fail DepositError, "Insufficient deposit" unless initial_deposit > MIN_DEPOSIT

    @password     = password
    @transactions = []
    @balance      = 0
    @name         = name
    @iban         = iban

    add_transaction(initial_deposit)
  end

  def withdraw(amount)
    # TODO: Call add_transaction with the right argument
    add_transaction(- amount)
    # @balance -= amount
    # TODO: returns a string with a message
    amount.to_s
  end

  def deposit(amount)
    # TODO: Call add_transaction with the right argument
    # TODO: returns a string with a message
    @balance += amount
    amount.to_s
  end

  def transactions_history(args = {})
    # TODO: Check if there is a password and if so if it is correct
    # TODO: return a string displaying the transactions, BUT NOT return the transaction array!
    puts args[:password]
    if args[:password].nil?
      'no password given'
    elsif @password == args[:password]
      @transactions.join
    elsif @password != args[:password]
      'wrong password'
    end
  end

  def iban
    # TODO: Hide the middle of the IBAN like FR14**************606 and return it
    @iban.gsub(/(?<=.{4})(.*)(?=.{3})/, '************')
  end

  def to_s
    # Method used when printing account object as string (also used for string interpolation)
    # TODO: return a string with the account owner, the hidden iban and the balance of the account
    "name: #{@name}, iban: #{iban}, balance: #{@balance}"
  end

  private

  def add_transaction(amount)
    # TODO: add the amount in the transactions array
    @transactions << amount
    # TODO: update the current balance (which represents the balance of the account)
    @balance += amount
  end
end
