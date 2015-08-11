require_relative 'test_helper'

class TestMerchant < Minitest::Test
  # def setup
  #   null_engine = SalesEngine.new
  # end

  def test_merchant_has_id
    merchant = Merchant.new("1",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC")
    assert_equal "1", merchant.id
  end

  def test_merchant_has_name
    merchant = Merchant.new("1",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC")
    assert_equal "Joe", merchant.name
  end

  def test_merchant_has_creation_date
    merchant = Merchant.new("1",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC")
    assert_equal "2012-03-27 14:53:59 UTC", merchant.created_at
  end

  def test_merchant_has_updated_date
    merchant = Merchant.new("1",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC")
    assert_equal "2012-03-27 14:53:59 UTC", merchant.updated_at
  end

  def test_item_method_returns_list_of_items
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    m_repo = engine.merchant_repository
    merchant = Merchant.new("1",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC",
                            m_repo)
    assert_equal 4, merchant.items.count
  end

  def test_item_method_with_no_matches_returns_empty_array
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    m_repo = engine.merchant_repository
    merchant = Merchant.new("6",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC",
                            m_repo)
    assert_equal [], merchant.items
  end

  def test_invoice_method_returns_list_of_invoices
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    m_repo = engine.merchant_repository
    merchant = Merchant.new("26",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC",
                            m_repo)
    assert_equal 2, merchant.invoices.count
  end

  def test_invoice_method_with_no_matches_returns_empty_array
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    m_repo = engine.merchant_repository
    merchant = Merchant.new("6",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC",
                            m_repo)
    assert_equal [], merchant.invoices
  end

  def test_successful_transactions_method_collects_transactions
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    m_repo = engine.merchant_repository
    merchant = Merchant.new("26",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC",
                            m_repo)
    assert_equal Transaction, merchant.successful_transactions.first.class
  end

  def test_successful_invoices_returns_invoices
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    m_repo = engine.merchant_repository
    merchant = Merchant.new("26",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC",
                            m_repo)
    assert_equal Invoice, merchant.successful_invoices.first.class
  end

  def test_successful_invoices_returns_empty_array_if_no_match
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    m_repo = engine.merchant_repository
    merchant = Merchant.new("1",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC",
                            m_repo)
    assert_equal [], merchant.successful_invoices
  end

  def test_successful_invoice_items_returns_invoice_items
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    m_repo = engine.merchant_repository
    merchant = Merchant.new("26",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC",
                            m_repo)
    assert_equal InvoiceItem, merchant.successful_invoice_items.first.class
  end

  def test_total_revenue
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    m_repo = engine.merchant_repository
    merchant = Merchant.new("26",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC",
                            m_repo)
    assert_equal 2780.91, merchant.revenue
  end

  def test_revenue_is_a_big_decimal
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    m_repo = engine.merchant_repository
    merchant = Merchant.new("26",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC",
                            m_repo)
    assert_equal BigDecimal, merchant.revenue.class
  end

  def test_revenue_by_date
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    m_repo = engine.merchant_repository
    merchant = Merchant.new("26",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC",
                            m_repo)
    assert_equal 2099.16, merchant.revenue("2012-03-12 05:54:09 UTC")
  end
  def test_revenue_by_date_is_a_bigdecimal_object
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    m_repo = engine.merchant_repository
    merchant = Merchant.new("26",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC",
                            m_repo)
    assert_equal BigDecimal, merchant.revenue("2012-03-12 05:54:09 UTC").class
  end

end