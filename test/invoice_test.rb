require_relative "test_helper"

class TestInvoice < Minitest::Test
  def test_invoice_has_id
    invoice = Invoice.new("1",
                          "1",
                          "26",
                          "shipped",
                          "2012-03-25 09:54:09 UTC",
                          "2012-03-25 09:54:09 UTC")
    assert_equal 1, invoice.id
  end

  def test_invoice_has_customer_id
    invoice = Invoice.new("1",
                          "1",
                          "26",
                          "shipped",
                          "2012-03-25 09:54:09 UTC",
                          "2012-03-25 09:54:09 UTC")
    assert_equal 1, invoice.customer_id
  end

  def test_invoice_has_merchant_id
    invoice = Invoice.new("1",
                          "1",
                          "26",
                          "shipped",
                          "2012-03-25 09:54:09 UTC",
                          "2012-03-25 09:54:09 UTC")
    assert_equal 26, invoice.merchant_id
  end

  def test_invoice_has_status
    invoice = Invoice.new("1",
                          "1",
                          "26",
                          "shipped",
                          "2012-03-25 09:54:09 UTC",
                          "2012-03-25 09:54:09 UTC")
    assert_equal "shipped", invoice.status
  end

  def test_invoice_has_creation_date
    invoice = Invoice.new("1",
                          "1",
                          "26",
                          "shipped",
                          "2012-03-25 09:54:09 UTC",
                          "2012-03-25 09:54:09 UTC")
    assert_equal Date.parse("2012-03-25 09:54:09 UTC"),
    invoice.created_at
  end

  def test_invoice_has_updated_date
    invoice = Invoice.new("1",
                          "1",
                          "26",
                          "shipped",
                          "2012-03-25 09:54:09 UTC",
                          "2012-03-25 09:54:09 UTC")
    assert_equal Date.parse("2012-03-25 09:54:09 UTC"),
    invoice.updated_at
  end

  def test_transactions_method_returns_list_of_transactions
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    i_repo = engine.invoice_repository
    invoice = Invoice.new("1",
                          "1",
                          "26",
                          "shipped",
                          "2012-03-25 09:54:09 UTC",
                          "2012-03-25 09:54:09 UTC",
                          i_repo)
    assert_equal 1, invoice.transactions.count
  end

  def test_transactions_method_returns_an_empty_array_if_no_matches
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    i_repo = engine.invoice_repository
    invoice = Invoice.new("888",
                          "1",
                          "26",
                          "shipped",
                          "2012-03-25 09:54:09 UTC",
                          "2012-03-25 09:54:09 UTC",
                          i_repo)
    assert_equal [], invoice.transactions
  end

  def test_invoice_items_method_returns_list_of_invoice_items
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    i_repo = engine.invoice_repository
    invoice = Invoice.new("1",
                          "1",
                          "26",
                          "shipped",
                          "2012-03-25 09:54:09 UTC",
                          "2012-03-25 09:54:09 UTC",
                          i_repo)
    assert_equal 3, invoice.invoice_items.count
  end

  def test_invoice_items_method_returns_empty_array_if_no_matches
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    i_repo = engine.invoice_repository
    invoice = Invoice.new("G",
                          "1",
                          "26",
                          "shipped",
                          "2012-03-25 09:54:09 UTC",
                          "2012-03-25 09:54:09 UTC",
                          i_repo)
    assert_equal [], invoice.invoice_items
  end

  def test_items_returns_list_of_items
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    i_repo = engine.invoice_repository
    invoice = Invoice.new("1",
                          "1",
                          "26",
                          "shipped",
                          "2012-03-25 09:54:09 UTC",
                          "2012-03-25 09:54:09 UTC",
                          i_repo)
    assert_equal 3, invoice.items.count
  end

  def test_customer_returns_a_single_customer
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    i_repo = engine.invoice_repository
    invoice = Invoice.new("1",
                          "1",
                          "26",
                          "shipped",
                          "2012-03-25 09:54:09 UTC",
                          "2012-03-25 09:54:09 UTC",
                          i_repo)
    assert_equal "Joey", invoice.customer.first_name
  end

  def test_invalid_customer_returns_nil
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    i_repo = engine.invoice_repository
    invoice = Invoice.new("1",
                          "32",
                          "26",
                          "shipped",
                          "2012-03-25 09:54:09 UTC",
                          "2012-03-25 09:54:09 UTC",
                          i_repo)
    assert_equal nil, invoice.customer
  end

  def test_merchant_method_returns_merchant
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    i_repo = engine.invoice_repository
    invoice = Invoice.new("1",
                          "1",
                          "2",
                          "shipped",
                          "2012-03-25 09:54:09 UTC",
                          "2012-03-25 09:54:09 UTC",
                          i_repo)
    assert_equal "Klein, Rempel and Jones", invoice.merchant.name
  end

  def test_merchant_method_with_no_match_returns_nil
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    i_repo = engine.invoice_repository
    invoice = Invoice.new("1",
                          "1",
                          "35",
                          "shipped",
                          "2012-03-25 09:54:09 UTC",
                          "2012-03-25 09:54:09 UTC",
                          i_repo)
    assert_equal nil, invoice.merchant
  end

end