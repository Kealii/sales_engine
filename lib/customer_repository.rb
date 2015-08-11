require_relative 'customer'
class CustomerRepository
  attr_reader :customers, :all_customers, :sales_engine

  def initialize(csvtable, sales_engine = "")
    @customers = csvtable
    @all_customers = make_customers
    @sales_engine = sales_engine
  end

  def make_customers
    customers.by_row.map do |row|
      Customer.new(row[:id],
                   row[:first_name],
                   row[:last_name],
                   row[:created_at],
                   row[:updated_at],
                   self)
    end
  end

  def all
    all_customers
  end

  def random
    all.sample
  end

  def find_by_id(id)
    all.detect {|customer| customer.id == id}
  end

  def find_by_first_name(first_name)
    all.detect {|customer| customer.first_name == first_name}
  end

  def find_by_last_name(last_name)
    all.detect {|customer| customer.last_name == last_name}
  end

  def find_by_created_at(created_date)
    all.detect {|customer| customer.created_at == created_date}
  end

  def find_by_updated_at(updated_date)
    all.detect {|customer| customer.updated_at == updated_date}
  end

  def find_all_by_id(id)
    all.select {|customer| customer.id == id}
  end

  def find_all_by_first_name(first_name)
    all.select {|customer| customer.first_name == first_name}
  end

  def find_all_by_last_name(last_name)
    all.select {|customer| customer.last_name == last_name}
  end

  def find_all_by_created_at(created_date)
    all.select {|customer| customer.created_at == created_date}
  end

  def find_all_by_updated_at(updated_date)
    all.select {|customer| customer.updated_at == updated_date}
  end

  def find_all_invoices_by_customer_id(id)
    sales_engine.find_all_invoices_by_customer_id(id)
  end

  def find_all_transactions_by_invoice_id(id)
    sales_engine.find_all_transactions_by_invoice_id(id)
  end

  def find_all_invoices_by_invoice_id(id)
    sales_engine.find_all_invoices_by_invoice_id(id)
  end

  def find_all_merchants_by_merchant_id(id)
    sales_engine.find_all_merchants_by_merchant_id(id)
  end
end
