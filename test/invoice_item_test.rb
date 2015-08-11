require_relative 'test_helper'

class TestInvoiceItem < Minitest::Test
  def test_invoice_item_has_id
    invoice_item = InvoiceItem.new("4",
                                  "535",
                                  "1",
                                  "3",
                                  "2196",
                                  "2012-03-27 14:54:09 UTC",
                                  "2012-03-27 14:54:09 UTC")
    assert_equal "4", invoice_item.id
  end

  def test_invoice_item_has_item_id
    invoice_item = InvoiceItem.new("4",
                                  "535",
                                  "1",
                                  "3",
                                  "2196",
                                  "2012-03-27 14:54:09 UTC",
                                  "2012-03-27 14:54:09 UTC")
    assert_equal "535", invoice_item.item_id
  end

  def test_invoice_item_has_invoice_id
    invoice_item = InvoiceItem.new("4",
                                  "535",
                                  "1",
                                  "3",
                                  "2196",
                                  "2012-03-27 14:54:09 UTC",
                                  "2012-03-27 14:54:09 UTC")
    assert_equal "1", invoice_item.invoice_id
  end

  def test_invoice_item_has_quantity
    invoice_item = InvoiceItem.new("4",
                                  "535",
                                  "1",
                                  "3",
                                  "2196",
                                  "2012-03-27 14:54:09 UTC",
                                  "2012-03-27 14:54:09 UTC")
    assert_equal 3, invoice_item.quantity
  end

  def test_invoice_item_has_unit_price
    invoice_item = InvoiceItem.new("4",
                                  "535",
                                  "1",
                                  "3",
                                  "2196",
                                  "2012-03-27 14:54:09 UTC",
                                  "2012-03-27 14:54:09 UTC")
    assert_equal 21.96, invoice_item.unit_price
  end

  def test_invoice_item_has_creation_date
    invoice_item = InvoiceItem.new("4",
                                  "535",
                                  "1",
                                  "3",
                                  "2196",
                                  "2012-03-27 14:54:09 UTC",
                                  "2012-03-27 14:54:09 UTC")
    assert_equal "2012-03-27 14:54:09 UTC", invoice_item.created_at
  end

  def test_invoice_item_has_updated_date
    invoice_item = InvoiceItem.new("4",
                                  "535",
                                  "1",
                                  "3",
                                  "2196",
                                  "2012-03-27 14:54:09 UTC",
                                  "2012-03-27 14:54:09 UTC")
    assert_equal "2012-03-27 14:54:09 UTC", invoice_item.updated_at
  end

  def test_invoice_returns_a_single_invoice
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    i_i_repo = engine.invoice_item_repository
    invoice_item = InvoiceItem.new("5",
                                  "535",
                                  "3",
                                  "3",
                                  "2196",
                                  "2012-03-27 14:54:09 UTC",
                                  "2012-03-27 14:54:09 UTC",
                                  i_i_repo)
    assert_equal "3", invoice_item.invoice.id
  end

  def test_invoice_returns_nil_if_no_match
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    i_i_repo = engine.invoice_item_repository
    invoice_item = InvoiceItem.new("4",
                                  "535",
                                  "5",
                                  "3",
                                  "2196",
                                  "2012-03-27 14:54:09 UTC",
                                  "2012-03-27 14:54:09 UTC",
                                  i_i_repo)
    assert_equal nil, invoice_item.invoice
  end

  def test_item_returns_a_single_item
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    i_i_repo = engine.invoice_item_repository
    invoice_item = InvoiceItem.new("1",
                                  "528",
                                  "1",
                                  "3",
                                  "2196",
                                  "2012-03-27 14:54:09 UTC",
                                  "2012-03-27 14:54:09 UTC",
                                  i_i_repo)
    assert_equal "Item Ea Voluptatum", invoice_item.item.name
  end

  def test_invoice_returns_nil_if_no_match
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    i_i_repo = engine.invoice_item_repository
    invoice_item = InvoiceItem.new("4",
                                  "535",
                                  "5",
                                  "3",
                                  "2196",
                                  "2012-03-27 14:54:09 UTC",
                                  "2012-03-27 14:54:09 UTC",
                                  i_i_repo)
    assert_equal nil, invoice_item.item
  end
end