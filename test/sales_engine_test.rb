require_relative "test_helper"

class TestSalesEngine < Minitest::Test
  def test_we_can_parse_merchant_data
    engine = SalesEngine.new("./data/fixtures")
    assert_equal CSV::Table, engine.parse("merchants.csv").class
  end

  def test_we_can_parse_invoice_data
    engine = SalesEngine.new("./data/fixtures")
    assert_equal CSV::Table, engine.parse("invoices.csv").class
  end

  def test_merchant_repository_method_gives_merchants
    engine = SalesEngine.new("./data/fixtures")
    assert_equal "1",
                 engine.merchant_repository.make_merchants.first.id
  end

  def test_invoice_repository_method_gives_merchants
    engine = SalesEngine.new("./data/fixtures")
    assert_equal "1",
                 engine.invoice_repository.make_invoices.first.id
  end

  def test_invoice_item_repository_method_gives_merchants
    engine = SalesEngine.new("./data/fixtures")
    assert_equal "1",
                 engine.invoice_item_repository.make_invoice_items.first.id
  end

  def test_customer_repository_method_gives_merchants
    engine = SalesEngine.new("./data/fixtures")
    assert_equal "1",
                 engine.customer_repository.make_customers.first.id
  end

  def test_item_repository_method_gives_merchants
    engine = SalesEngine.new("./data/fixtures")
    assert_equal "1",
                 engine.item_repository.make_items.first.id
  end
end