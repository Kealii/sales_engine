class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :invoice_repository

  def initialize(id,
                 customer_id,
                 merchant_id,
                 status,
                 created_at,
                 updated_at,
                 invoice_repository = "")

    @id          = id
    @customer_id = customer_id
    @merchant_id = merchant_id
    @status      = status
    @created_at  = created_at
    @updated_at  = updated_at
    @invoice_repository = invoice_repository
  end

  def transactions
    invoice_repository.find_all_transactions_by_invoice_id(id)
  end

  def invoice_items
    invoice_repository.find_all_invoice_items_by_invoice_id(id)
  end

  def item_ids_from_invoice_items
    invoice_items.map {|item| item.item_id}
  end

  def items
    item_ids_from_invoice_items.flat_map do |id|
      invoice_repository.find_all_items_by_item_id(id)
    end
  end

  def customer
    invoice_repository.find_customer_by_customer_id(customer_id)
  end

  def merchant
    invoice_repository.find_merchant_by_merchant_id(merchant_id)
  end
end