require "bigdecimal"
require "date"

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :merchant_repository

  def initialize(id, name, created_at, updated_at, merchant_repository = "")
    @id = id.to_i
    @name = name
    @created_at = Date.parse(created_at)
    @updated_at = Date.parse(updated_at)
    @merchant_repository = merchant_repository
  end

  def items
    merchant_repository.find_all_items_by_merchant_id(id)
  end

  def invoices
    merchant_repository.find_all_invoices_by_merchant_id(id)
  end

  def all_transactions
    invoices.flat_map do |invoice|
      merchant_repository.all_transactions(invoice.id)
    end
  end

  def successful_transactions
    all_transactions.select {|transaction| transaction.success?}
  end

  def successful_invoices
    successful_transactions.flat_map do |transaction|
      invoice_id = transaction.invoice_id
      merchant_repository.find_all_invoices_by_invoice_id(invoice_id)
    end
  end

  def successful_invoice_items
    successful_invoices.flat_map do |invoice|
      merchant_repository.find_all_invoice_items_by_invoice_id(invoice.id)
    end
  end

  def successful_invoice_items_by_date(date)
    successful_invoices_by_date(date).flat_map do |invoice|
      merchant_repository.find_all_invoice_items_by_invoice_id(invoice.id)
    end
  end

  def successful_invoices_by_date(date)
    successful_invoices.select do |invoice|
      invoice.created_at == date
    end
  end

  def revenue(date = nil)
    date ? revenue_by_date(date) : total_revenue
  end

  def total_revenue
    successful_invoice_items.flat_map do |invoice_item|
      invoice_item.total
    end.inject(:+)
  end

  def revenue_by_date(date)
    successful_invoice_items_by_date(date).flat_map do |invoice_item|
      invoice_item.total
    end.inject(:+)
  end

  def total_quantities
    successful_invoice_items.flat_map do |invoice_item|
      invoice_item.quantity
    end.inject(:+)
  end

  def all_successful_customers
    successful_invoices.flat_map do |invoice|
      merchant_repository.find_all_customers_by_customer_id(invoice.customer_id)
    end
  end

  def customer_appearances
    all_successful_customers.each_with_object(Hash.new(0)) do |customer, counts|
      counts[customer] += 1
    end
  end

  def sorted_customers
    customer_appearances.sort_by {|k, v| -v}.flatten
  end

  def favorite_customer
    sorted_customers.first
  end
end