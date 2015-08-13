require "date"
class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :item_repository

  def initialize(id,
                 name,
                 description,
                 unit_price,
                 merchant_id,
                 created_at,
                 updated_at,
                 item_repository = "")

    @id                = id.to_i
    @name              = name
    @description       = description
    @unit_price        = BigDecimal.new(unit_price.to_i)/100
    @merchant_id       = merchant_id.to_i
    @created_at        = Date.parse(created_at)
    @updated_at        = Date.parse(updated_at)
    @item_repository   = item_repository
  end

  def invoice_items
    item_repository.find_all_invoice_items_by_item_id(id)
  end

  def merchant
    item_repository.find_merchant_by_merchant_id(merchant_id)
  end

  def best_day
    invoice_items.max_by do |invoice_item|
      invoice_item.quantity
    end.invoice.created_at
  end

  def invoices
    invoice_items.flat_map do |invoice_item|
      item_repository.find_all_invoices_by_invoice_id(invoice_item.invoice_id)
    end
  end

  def transactions
    invoices.flat_map do |invoice|
      item_repository.find_all_transactions_by_invoice_id(invoice.id)
    end
  end

  def successful_transactions
    transactions.select {|transaction| transaction.success?}
  end

  def successful_invoices
    successful_transactions.flat_map do |transaction|
      item_repository.find_all_invoices_by_invoice_id(transaction.invoice_id)
    end
  end

  def successful_invoice_items
    successful_invoices.flat_map do |invoice|
      item_repository.find_all_invoice_items_by_invoice_id(invoice.id)
    end
  end

  def filtered_invoice_items
    successful_invoice_items.select do |invoice_item|
      invoice_item.item_id == id
    end
  end

  def total_quantities
    filtered_invoice_items.inject(0) do |total, invoice_item|
      total += invoice_item.quantity
      total
    end
  end
end