require'pry'

class Transfer

  attr_reader :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end
  
  def valid?
    @sender.valid? && @receiver.valid?
  end
  
  def execute_transaction
    if valid? && @sender.balance - @amount > 0 && @status != "complete"
      @sender.deposit(-@amount) 
      @receiver.deposit(@amount)
      @status = "complete"
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end
  
  def reverse_transfer
    binding.pry
    @sender.deposit(@amount)
    @receiver.deposit(-@amount)
    @status = "reversed"
  end
  
end
