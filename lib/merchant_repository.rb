require_relative 'merchant'
class MerchantRepository
  attr_reader :merchants, :all_merchants, :sales_engine

  def initialize(csvtable, sales_engine = "")
    @merchants = csvtable
    @all_merchants = make_merchants
    @sales_engine = sales_engine
  end

  def make_merchants
    merchants.by_row.map do |row|
      Merchant.new(row[:id],
                   row[:name],
                   row[:created_at],
                   row[:updated_at],
                   self)
    end
  end

  def all
    all_merchants
  end

  def random
    all.sample
  end

  def find_by_id(id)
    all.detect {|merchant| merchant.id == id}
  end

  def find_by_name(name)
    all.detect {|merchant| merchant.name == name}
  end

  def find_by_created_at(date)
    all.detect {|merchant| merchant.created_at == date}
  end

  def find_by_updated_at(date)
    all.detect {|merchant| merchant.updated_at == date}
  end

  def find_all_by_id(id)
    all.select {|merchant| merchant.id == id}
  end

  def find_all_by_name(name)
    all.select {|merchant| merchant.name == name}
  end

  def find_all_by_created_at(date)
    all.select {|merchant| merchant.created_at == date}
  end

  def find_all_by_updated_at(date)
    all.select {|merchant| merchant.updated_at == date}
  end

  def find_all_items_by_merchant_id(id)
    sales_engine.find_all_items_by_merchant_id(id)
  end

  def find_all_invoices_by_merchant_id(id)
    sales_engine.find_all_invoices_by_merchant_id(id)
  end

  def all_transactions(invoice_id)
      sales_engine.all_transactions(invoice_id)
  end
  
  def find_all_invoices_by_invoice_id(id)
    sales_engine.find_all_invoices_by_id(id)
  end

  def find_all_invoice_items_by_invoice_id(id)
    sales_engine.find_all_invoice_items_by_id(id)
  end
end
