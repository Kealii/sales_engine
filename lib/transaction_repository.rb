require_relative 'transaction'
class TransactionRepository
  attr_reader :transactions, :all_transactions, :sales_engine

  def initialize(csvtable, sales_engine = "")
    @transactions = csvtable
    @all_transactions = make_transactions
    @sales_engine = sales_engine
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def make_transactions
    transactions.by_row.map do |row|
      Transaction.new(row[:id],
                      row[:invoice_id],
                      row[:credit_card_number],
                      row[:credit_card_expiration_date],
                      row[:result],
                      row[:created_at],
                      row[:updated_at],
                      self)
    end
  end

  def all
  	all_transactions
  end

  def random
  	all.sample
  end

  def find_by_id(id)
    all.detect {|transaction| transaction.id == id}
  end

  def find_by_invoice_id(invoice_id)
    all.detect {|transaction| transaction.invoice_id == invoice_id}
  end

  def find_by_credit_card_number(credit_card_number)
    all.detect {|transaction| transaction.credit_card_number == credit_card_number}
  end

  def find_by_credit_card_expiration_date(credit_card_expiration_date)
    all.detect {|transaction| transaction.credit_card_expiration_date == credit_card_expiration_date}
  end

  def find_by_result(result)
    all.detect {|transaction| transaction.result == result}
  end

  def find_by_created_at(date)
    all.detect {|transaction| transaction.created_at == date}
  end

  def find_by_updated_at(date)
    all.detect {|transaction| transaction.updated_at == date}
  end

  def find_all_by_id(id)
    all.select {|transaction| transaction.id == id}
  end

  def find_all_by_invoice_id(invoice_id)
    all.select {|transaction| transaction.invoice_id == invoice_id}
  end

  def find_all_by_credit_card_number(credit_card_number)
    all.select {|transaction| transaction.credit_card_number == credit_card_number}
  end

  def find_all_by_credit_card_expiration_date(credit_card_expiration_date)
    all.select {|transaction| transaction.credit_card_expiration_date == credit_card_expiration_date}
  end

  def find_all_by_result(result)
    all.select {|transaction| transaction.result == result}
  end

  def find_all_by_created_at(date)
    all.select {|transaction| transaction.created_at == date}
  end

  def find_all_by_updated_at(date)
    all.select {|transaction| transaction.updated_at == date}
  end

  def find_invoices_by_invoice_id(id)
    sales_engine.find_by_invoice_id(id)
  end

end
