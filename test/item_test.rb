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
    assert_equal 75107, item.unit_price
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
    assert_equal "2012-03-27 14:53:59 UTC", item.created_at
  end

  def test_item_has_updated_date
    item = Item.new(1,
                    "Item Qui Esse",
                    "Nihil autem sit odio inventore deleniti.",
                    75107,
                    1,
                    "2012-03-27 14:53:59 UTC",
                    "2012-03-27 14:53:59 UTC")
    assert_equal "2012-03-27 14:53:59 UTC", item.updated_at
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
    assert_equal 2, item.invoice_item.count
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
    assert_equal [], item.invoice_item
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
end