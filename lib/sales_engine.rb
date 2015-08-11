require 'csv'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'
require_relative 'transaction_repository'
require_relative 'item_repository'


class SalesEngine

  attr_reader :merchant_repository,
              :invoice_repository,
              :invoice_item_repository,
              :customer_repository,
              :transaction_repository,
              :item_repository

  def initialize(path = "./data")
    @path = path
    startup
  end

  def parse(file)
    CSV.read "#{@path}/#{file}",
    headers: true, header_converters: :symbol
  end

  def startup
    merchants     = parse("merchants.csv")
    invoices      = parse("invoices.csv")
    invoice_items = parse("invoice_items.csv")
    customers     = parse("customers.csv")
    transactions  = parse("transactions.csv")
    items         = parse("items.csv")

    @merchant_repository     = MerchantRepository.new(merchants, self)
    @invoice_repository      = InvoiceRepository.new(invoices, self)
    @invoice_item_repository = InvoiceItemRepository.new(invoice_items, self)
    @customer_repository     = CustomerRepository.new(customers, self)
    @transaction_repository  = TransactionRepository.new(transactions, self)
    @item_repository         = ItemRepository.new(items, self)
  end

  def find_all_items_by_merchant_id(id)
    item_repository.find_all_by_merchant_id(id)
  end

  def find_all_invoices_by_merchant_id(id)
    invoice_repository.find_all_by_merchant_id(id)
  end

  def find_all_transactions_by_invoice_id(id)
    transaction_repository.find_all_by_invoice_id(id)
  end

  def find_all_invoice_items_by_invoice_id(id)
    invoice_item_repository.find_all_by_invoice_id(id)
  end

  def find_all_items_by_item_id(id)
    item_repository.find_all_by_id(id)
  end

  def find_by_customer_id(id)
    customer_repository.find_by_id(id)
  end

  def find_by_merchant_id(id)
    merchant_repository.find_by_id(id)
  end

  def find_by_invoice_id(id)
    invoice_repository.find_by_id(id)
  end

  def find_by_item_id(id)
    item_repository.find_by_id(id)
  end

  def find_all_invoice_items_by_item_id(id)
    invoice_item_repository.find_all_by_item_id(id)
  end

  def find_all_invoices_by_id(id)
    invoice_repository.find_all_by_id(id)
  end

  def all_transactions(invoice_id)
    transaction_repository.find_all_by_invoice_id(invoice_id)
  end

  def find_all_invoices_by_invoice_id(id)
    invoice_repository.find_all_by_id(id)
  end

  def find_all_invoice_items_by_id(id)
    invoice_item_repository.find_all_by_id(id)
  end

  def find_all_invoices_by_customer_id(id)
    invoice_repository.find_all_by_customer_id(id)
  end

  def find_all_merchants_by_merchant_id(id)
    merchant_repository.find_all_by_id(id)
  end

end