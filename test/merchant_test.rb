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
    assert_equal 1, merchant.id
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
    assert_equal Date.parse("2012-03-27 14:53:59 UTC"), merchant.created_at
  end

  def test_merchant_has_updated_date
    merchant = Merchant.new("1",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC")
    assert_equal Date.parse("2012-03-27 14:53:59 UTC"), merchant.updated_at
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
    assert_equal 1, merchant.invoices.first.id
    assert_equal 2, merchant.invoices[1].id
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

  def test_all_transactactions_method_collects_all_transactions
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    m_repo = engine.merchant_repository
    merchant = Merchant.new("26",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC",
                            m_repo)
    assert_equal 1, merchant.all_transactions.first.id
    assert_equal 2, merchant.all_transactions.last.id
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

  def test_successful_transactions_method_collects_all_successful_transactions
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    m_repo = engine.merchant_repository
    merchant = Merchant.new("26",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC",
                            m_repo)
    assert_equal 2, merchant.successful_transactions.count
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

  def test_successful_invoices_returns_all_successful_invoices
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    m_repo = engine.merchant_repository
    merchant = Merchant.new("26",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC",
                            m_repo)
    assert_equal 2, merchant.successful_invoices.count
    assert_equal 2, merchant.successful_invoices.last.id
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

  def test_successful_invoice_items_returns_all_successful_invoice_items
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    m_repo = engine.merchant_repository
    merchant = Merchant.new("26",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC",
                            m_repo)
    assert_equal 4, merchant.successful_invoice_items.count
    assert_equal 348.73, merchant.successful_invoice_items.last.unit_price
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
    assert_equal 7669.91, merchant.revenue
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
    date = Date.parse("2012-03-12 05:54:09 UTC")
    assert_equal 2789.84, merchant.revenue(date)
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
    date = Date.parse("2012-03-12 05:54:09 UTC")
    assert_equal BigDecimal, merchant.revenue(date).class
  end

  def test_all_successful_customers_method_returns_collection_of_customers
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    m_repo = engine.merchant_repository
    merchant = Merchant.new("26",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC",
                            m_repo)
    assert_equal Customer, merchant.all_successful_customers.first.class
    assert_equal 2, merchant.all_successful_customers.count
  end

  def test_customer_appearances_returns_customers_and_count
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    m_repo = engine.merchant_repository
    merchant = Merchant.new("26",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC",
                            m_repo)
    assert_equal Customer, merchant.customer_appearances.first[0].class
    assert_equal 2, merchant.customer_appearances.first[1]
  end

  def test_sorted_customers_returns_highest_count_first
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    m_repo = engine.merchant_repository
    merchant = Merchant.new("26",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC",
                            m_repo)
    assert_equal "Joey", merchant.sorted_customers.first.first_name
    assert_equal 2, merchant.sorted_customers.last
  end

  def test_favorite_customer_returns_top_ranked_customer
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    m_repo = engine.merchant_repository
    merchant = Merchant.new("26",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC",
                            m_repo)
    assert_equal "Joey", merchant.favorite_customer.first_name
  end

  def test_pending_invoices_returns_failed_invoices
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    m_repo = engine.merchant_repository
    merchant = Merchant.new("34",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC",
                            m_repo)
    assert_equal 13, merchant.pending_invoices.first.id
    assert_equal Invoice, merchant.pending_invoices.first.class
  end

  def test_pending_invoices_returns_failed_invoices
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    m_repo = engine.merchant_repository
    merchant = Merchant.new("34",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC",
                            m_repo)
    assert_equal 13, merchant.pending_invoices.first.id
    assert_equal Invoice, merchant.pending_invoices.first.class
  end

  def test_customers_with_pending_invoices_returns_collection_of_customers
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    m_repo = engine.merchant_repository
    merchant = Merchant.new("34",
                            "Joe",
                            "2012-03-27 14:53:59 UTC",
                            "2012-03-27 14:53:59 UTC",
                            m_repo)
    assert_equal 2, merchant.customers_with_pending_invoices.count
    assert_equal Customer, merchant.customers_with_pending_invoices.first.class
  end
end