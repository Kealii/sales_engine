require_relative "test_helper"

class TestItem < Minitest::Test
  def test_item_has_id
    item = Item.new(1,
                    "Item Qui Esse",
                    "Nihil autem sit odio inventore deleniti.",
                    75107,
                    1,
                    "2012-03-27 14:53:59 UTC",
                    "2012-03-27 14:53:59 UTC")
    assert_equal 1, item.id
  end

  def test_item_has_name
    item = Item.new(1,
                    "Item Qui Esse",
                    "Nihil autem sit odio inventore deleniti.",
                    75107,
                    1,
                    "2012-03-27 14:53:59 UTC",
                    "2012-03-27 14:53:59 UTC")
    assert_equal "Item Qui Esse", item.name
  end

  def test_item_has_description
    item = Item.new(1,
                    "Item Qui Esse",
                    "Nihil autem sit odio inventore deleniti.",
                    75107,
                    1,
                    "2012-03-27 14:53:59 UTC",
                    "2012-03-27 14:53:59 UTC")
    assert_equal "Nihil autem sit odio inventore deleniti.", item.description
  end

  def test_item_has_unit_price
    item = Item.new(1,
                    "Item Qui Esse",
                    "Nihil autem sit odio inventore deleniti.",
                    75107,
                    1,
                    "2012-03-27 14:53:59 UTC",
                    "2012-03-27 14:53:59 UTC")
    assert_equal BigDecimal, item.unit_price.class
  end

  def test_item_has_merchant_id
    item = Item.new(1,
                    "Item Qui Esse",
                    "Nihil autem sit odio inventore deleniti.",
                    75107,
                    1,
                    "2012-03-27 14:53:59 UTC",
                    "2012-03-27 14:53:59 UTC")
    assert_equal 1, item.merchant_id
  end

  def test_item_has_creation_date
    item = Item.new(1,
                    "Item Qui Esse",
                    "Nihil autem sit odio inventore deleniti.",
                    75107,
                    1,
                    "2012-03-27 14:53:59 UTC",
                    "2012-03-27 14:53:59 UTC")
    assert_equal Date.parse("2012-03-27 14:53:59 UTC"), item.created_at
  end

  def test_item_has_updated_date
    item = Item.new(1,
                    "Item Qui Esse",
                    "Nihil autem sit odio inventore deleniti.",
                    75107,
                    1,
                    "2012-03-27 14:53:59 UTC",
                    "2012-03-27 14:53:59 UTC")
    assert_equal Date.parse("2012-03-27 14:53:59 UTC"), item.updated_at
  end

  def test_invoice_item_method
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    i_repo = engine.item_repository
    item = Item.new("1",
                    "Item Qui Esse",
                    "Nihil autem sit odio inventore deleniti.",
                    "75107",
                    "1",
                    "2012-03-27 14:53:59 UTC",
                    "2012-03-27 14:53:59 UTC",
                    i_repo)
    assert_equal 2, item.invoice_items.count
  end

  def test_invoice_item_method_returns_empty_array_if_no_matches
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    i_repo = engine.item_repository
    item = Item.new("33",
                    "Item Qui Esse",
                    "Nihil autem sit odio inventore deleniti.",
                    "75107",
                    "1",
                    "2012-03-27 14:53:59 UTC",
                    "2012-03-27 14:53:59 UTC",
                    i_repo)
    assert_equal [], item.invoice_items
  end

  def test_merchant_method
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    i_repo = engine.item_repository
    item = Item.new("1",
                    "Item Qui Esse",
                    "Nihil autem sit odio inventore deleniti.",
                    "75107",
                    "1",
                    "2012-03-27 14:53:59 UTC",
                    "2012-03-27 14:53:59 UTC",
                    i_repo)
    assert_equal Merchant, item.merchant.class
  end

  def test_merchant_method_returns_nil_if_no_matches
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    i_repo = engine.item_repository
    item = Item.new("1",
                    "Item Qui Esse",
                    "Nihil autem sit odio inventore deleniti.",
                    "75107",
                    "69",
                    "2012-03-27 14:53:59 UTC",
                    "2012-03-27 14:53:59 UTC",
                    i_repo)
    assert_equal nil, item.merchant
  end

  def test_invoices_method_returns_invoices
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    i_repo = engine.item_repository
    item = Item.new("1",
                    "Item Qui Esse",
                    "Nihil autem sit odio inventore deleniti.",
                    "75107",
                    "69",
                    "2012-03-27 14:53:59 UTC",
                    "2012-03-27 14:53:59 UTC",
                    i_repo)
    assert_equal Invoice, item.invoices.first.class
  end

  def test_transactions_method_returns_transactions
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    i_repo = engine.item_repository
    item = Item.new("1",
                    "Item Qui Esse",
                    "Nihil autem sit odio inventore deleniti.",
                    "75107",
                    "69",
                    "2012-03-27 14:53:59 UTC",
                    "2012-03-27 14:53:59 UTC",
                    i_repo)
    assert_equal Transaction, item.transactions.first.class
    assert_equal 1, item.transactions.count
  end

  def test_successful_transactions_method_returns_successful_transactions
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    i_repo = engine.item_repository
    item = Item.new("1",
                    "Item Qui Esse",
                    "Nihil autem sit odio inventore deleniti.",
                    "75107",
                    "69",
                    "2012-03-27 14:53:59 UTC",
                    "2012-03-27 14:53:59 UTC",
                    i_repo)
    result = item.successful_transactions.any? do |transaction|
      transaction.result == "failed"
    end
    assert_equal Transaction, item.successful_transactions.first.class
    assert_equal false, result
  end

  def test_successful_invoices_method_returns_invoices
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    i_repo = engine.item_repository
    item = Item.new("1",
                    "Item Qui Esse",
                    "Nihil autem sit odio inventore deleniti.",
                    "75107",
                    "69",
                    "2012-03-27 14:53:59 UTC",
                    "2012-03-27 14:53:59 UTC",
                    i_repo)
    assert_equal Invoice, item.successful_invoices.first.class
    assert_equal 1, item.successful_invoices.count
  end

  def test_successful_invoice_items_method_returns_invoice_items
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    i_repo = engine.item_repository
    item = Item.new("1",
                    "Item Qui Esse",
                    "Nihil autem sit odio inventore deleniti.",
                    "75107",
                    "69",
                    "2012-03-27 14:53:59 UTC",
                    "2012-03-27 14:53:59 UTC",
                    i_repo)
    assert_equal InvoiceItem, item.successful_invoice_items.first.class
    assert_equal 3, item.successful_invoice_items.count
  end

  def test_filtered_invoice_items
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    i_repo = engine.item_repository
    item = Item.new("1",
                    "Item Qui Esse",
                    "Nihil autem sit odio inventore deleniti.",
                    "75107",
                    "69",
                    "2012-03-27 14:53:59 UTC",
                    "2012-03-27 14:53:59 UTC",
                    i_repo)
    assert_equal 2, item.filtered_invoice_items.count
  end

  def test_total_quantities_method_does_stuff_right
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    i_repo = engine.item_repository
    item = Item.new("1",
                    "Item Qui Esse",
                    "Nihil autem sit odio inventore deleniti.",
                    "75107",
                    "69",
                    "2012-03-27 14:53:59 UTC",
                    "2012-03-27 14:53:59 UTC",
                    i_repo)
    assert_equal 18, item.total_quantities
  end
end