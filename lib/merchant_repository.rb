require_relative 'merchant'
class MerchantRepository
  attr_reader :merchants, :all_merchants, :sales_engine

  def initialize(csvtable, sales_engine = "")
    @merchants = csvtable
    @all_merchants = make_merchants
    @sales_engine = sales_engine
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
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

  def all_merchant_revenues
    all.map{|merchant| {merchant => merchant.revenue}}
  end

  def sorted_merchant_revenues
    all_merchant_revenues.sort_by {|merchant| -(merchant.values[0].to_i)}
  end

  def most_revenue(x)
    sorted_merchant_revenues.flat_map do |merchant_data|
      merchant_data.keys
    end[0..(x-1)]
  end

  def revenue(date)
    all.flat_map do |merchant|
      merchant.revenue_by_date(date) == nil ? 0 : merchant.revenue_by_date(date)
    end.inject(:+)
  end

  def merchants_with_item_quantities
    all.flat_map {|merchant| {merchant => merchant.total_quantities}}
  end

  def sorted_merchant_items
    merchants_with_item_quantities.sort_by {|merchant| -(merchant.values[0].to_i)}
  end

  def most_items(x)
    sorted_merchant_items.flat_map do |merchant_data|
      merchant_data.keys
    end[0..(x-1)]

  end

end
