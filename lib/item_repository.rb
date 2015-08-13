require_relative 'item'
class ItemRepository
  attr_reader :items, :all_items, :sales_engine

  def initialize(csvtable, sales_engine = "")
    @items = csvtable
    @all_items = make_items
    @sales_engine = sales_engine
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def make_items
    items.by_row.map do |row|
      Item.new(row[:id],
               row[:name],
               row[:description],
               row[:unit_price],
               row[:merchant_id],
               row[:created_at],
               row[:updated_at],
               self)
    end
  end

  def all
    all_items
  end

  def random
    all.sample
  end

  def find_by_id(id)
    all.detect {|item| item.id == id}
  end

  def find_by_name(name)
    all.detect {|item| item.name == name}
  end

  def find_by_description(description)
    all.detect {|item| item.description == description}
  end

  def find_by_unit_price(unit_price)
    all.detect {|item| item.unit_price == unit_price}
  end

  def find_by_merchant_id(merchant_id)
    all.detect {|item| item.merchant_id == merchant_id}
  end

  def find_by_created_at(created_date)
    all.detect {|item| item.created_at == created_date}
  end

  def find_by_updated_at(updated_date)
    all.detect {|item| item.updated_at == updated_date}
  end

  def find_all_by_id(id)
    all.select {|item| item.id == id}
  end

  def find_all_by_name(name)
    all.select {|item| item.name == name}
  end

  def find_all_by_description(description)
    all.select {|item| item.description == description}
  end

  def find_all_by_unit_price(unit_price)
    all.select {|item| item.unit_price == unit_price}
  end

  def find_all_by_merchant_id(merchant_id)
    all.select {|item| item.merchant_id == merchant_id}
  end

  def find_all_by_created_at(created_date)
    all.select {|item| item.created_at == created_date}
  end

  def find_all_by_updated_at(updated_date)
    all.select {|item| item.updated_at == updated_date}
  end

  def find_all_invoice_items_by_item_id(id)
    sales_engine.find_all_invoice_items_by_item_id(id)
  end

  def find_merchant_by_merchant_id(id)
    sales_engine.find_by_merchant_id(id)
  end

  def find_all_invoices_by_invoice_id(id)
    sales_engine.find_all_invoices_by_id(id)
  end

  def find_all_transactions_by_invoice_id(id)
    sales_engine.find_all_transactions_by_invoice_id(id)
  end

  def find_all_invoice_items_by_invoice_id(id)
      sales_engine.find_all_invoice_items_by_invoice_id(id)
  end

  def items_with_item_quantities
    all.flat_map {|item| {item => item.total_quantities}}
  end

  def sorted_merchant_items
    merchants_with_item_quantities.sort_by do |merchant|
     -(merchant.values[0].to_i)
   end
  end

  def most_items(x)
    sorted_merchant_items.flat_map do |merchant_data|
      merchant_data.keys
    end[0..(x-1)]
  end
end
