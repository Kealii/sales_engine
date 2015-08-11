class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :customer_repository

  def initialize(id,
                 first_name,
                 last_name,
                 created_at,
                 updated_at,
                 customer_repository = "")

    @id            = id
    @first_name    = first_name
    @last_name     = last_name
    @created_at    = created_at
    @updated_at    = updated_at
    @customer_repository = customer_repository
  end

  def invoices
    customer_repository.find_all_invoices_by_customer_id(id)
  end

  def transactions
    invoices.flat_map do |invoice|
      customer_repository.find_all_transactions_by_invoice_id(invoice.id)
    end
  end

  def successful_transactions
    transactions.select {|transaction| transaction.success?}
  end

  def successful_invoices
    successful_transactions.flat_map do |transaction|
      customer_repository.find_all_invoices_by_invoice_id(transaction.invoice_id)
    end
  end

  def all_successful_merchants
    successful_invoices.flat_map do |invoice|
      customer_repository.find_all_merchants_by_merchant_id(invoice.merchant_id)
    end
  end

  def merchant_appearances
    all_successful_merchants.each_with_object(Hash.new(0)) do |merchant, counts|
      counts[merchant] += 1
    end
  end

  def sorted_merchants
    merchant_appearances.sort_by {|k, v| -v}.flatten
  end

  def favorite_merchant
    sorted_merchants.first
  end

end