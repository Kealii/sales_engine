require_relative 'invoice'
class InvoiceRepository
  attr_reader :invoices, :all_invoices, :sales_engine

  def initialize(csvtable, sales_engine = "")
    @invoices     = csvtable
    @all_invoices = make_invoices
    @sales_engine = sales_engine
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def make_invoices
    invoices.by_row.map do |row|
      Invoice.new(row[:id],
                  row[:customer_id],
                  row[:merchant_id],
                  row[:status],
                  row[:created_at],
                  row[:updated_at],
                  self)
    end
  end

  def all
    all_invoices
  end

  def random
    all.sample
  end

  def find_by_id(id)
    all.detect {|invoice| invoice.id == id}
  end

  def find_by_customer_id(customer_id)
    all.detect {|invoice| invoice.customer_id == customer_id}
  end

  def find_by_merchant_id(merchant_id)
    all.detect {|invoice| invoice.merchant_id == merchant_id}
  end

  def find_by_status(status)
    all.detect {|invoice| invoice.status == status}
  end

  def find_by_created_at(created_date)
    all.detect {|invoice| invoice.created_at == created_date}
  end

  def find_by_updated_at(updated_date)
    all.detect {|invoice| invoice.updated_at == updated_date}
  end

  def find_all_by_id(id)
    all.select {|invoice| invoice.id == id}
  end

  def find_all_by_customer_id(customer_id)
    all.select {|invoice| invoice.customer_id == customer_id}
  end

  def find_all_by_merchant_id(merchant_id)
    all.select {|invoice| invoice.merchant_id == merchant_id}
  end

  def find_all_by_status(status)
    all.select {|invoice| invoice.status == status}
  end

  def find_all_by_created_at(created_date)
    all.select {|invoice| invoice.created_at == created_date}
  end

  def find_all_by_updated_at(updated_date)
    all.select {|invoice| invoice.updated_at == updated_date}
  end

  def find_all_transactions_by_invoice_id(id)
    sales_engine.find_all_transactions_by_invoice_id(id)
  end

  def find_all_invoice_items_by_invoice_id(id)
    sales_engine.find_all_invoice_items_by_invoice_id(id)
  end

  def find_all_items_by_item_id(id)
    sales_engine.find_all_items_by_item_id(id)
  end

  def find_customer_by_customer_id(id)
    sales_engine.find_by_customer_id(id)
  end

  def find_merchant_by_merchant_id(id)
    sales_engine.find_by_merchant_id(id)
  end

  def create(args)
    invoice = Invoice.new((all_invoices.last.id + 1),
                        args[:customer].id,
                        args[:merchant].id,
                        args[:status],
                        Time.now.to_s,
                        Time.now.to_s,
                        self)

    @all_invoices << invoice
    sales_engine.add_items(args[:items], invoice.id)
    invoice
  end

  def charge(data, id)
    sales_engine.charge(data, id)
  end
end
