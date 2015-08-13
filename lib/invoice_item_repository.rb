require_relative 'invoice_item'

class InvoiceItemRepository
  attr_reader :invoice_items, :all_invoice_items, :sales_engine

  def initialize(csvtable, sales_engine = "")
    @invoice_items = csvtable
    @all_invoice_items = make_invoice_items
    @sales_engine = sales_engine
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def make_invoice_items
    invoice_items.by_row.map do |row|
      InvoiceItem.new(row[:id],
                      row[:item_id],
                      row[:invoice_id],
                      row[:quantity],
                      row[:unit_price],
                      row[:created_at],
                      row[:updated_at],
                      self)
    end
  end

  def all
    all_invoice_items
  end

  def random
    all_invoice_items.sample
  end

    def find_by_id(id)
    all.detect {|invoice_item| invoice_item.id == id}
  end

  def find_by_item_id(item_id)
    all.detect {|invoice_item| invoice_item.item_id == item_id}
  end

  def find_by_invoice_id(invoice_id)
    all.detect {|invoice_item| invoice_item.invoice_id == invoice_id}
  end

  def find_by_quantity(quantity)
    all.detect {|invoice_item| invoice_item.quantity == quantity}
  end

  def find_by_unit_price(unit_price)
    all.detect {|invoice_item| invoice_item.unit_price == unit_price}
  end

  def find_by_created_at(date)
    all.detect {|invoice_item| invoice_item.created_at == date}
  end

  def find_by_updated_at(date)
    all.detect {|invoice_item| invoice_item.updated_at == date}
  end

  def find_all_by_id(id)
    all.select {|invoice_item| invoice_item.id == id}
  end

  def find_all_by_item_id(item_id)
    all.select {|invoice_item| invoice_item.item_id == item_id}
  end

  def find_all_by_invoice_id(invoice_id)
    all.select {|invoice_item| invoice_item.invoice_id == invoice_id}
  end

  def find_all_by_quantity(quantity)
    all.select {|invoice_item| invoice_item.quantity == quantity}
  end

  def find_all_by_unit_price(unit_price)
    all.select {|invoice_item| invoice_item.unit_price == unit_price}
  end

  def find_all_by_created_at(date)
    all.select {|invoice_item| invoice_item.created_at == date}
  end

  def find_all_by_updated_at(date)
    all.select {|invoice_item| invoice_item.updated_at == date}
  end

  def find_invoice_by_invoice_id(id)
    sales_engine.find_by_invoice_id(id)
  end

  def find_item_by_item_id(id)
    sales_engine.find_by_item_id(id)
  end

  def add_items(args, invoice_id)
    args.each do |item|
    ii = InvoiceItem.new((all_invoice_items.last.id + 1),
                         item.id,
                         invoice_id,
                         1,
                         item.unit_price,
                         Time.now.to_s,
                         Time.now.to_s,
                         self)
      all_invoice_items << ii
    end
  end
end