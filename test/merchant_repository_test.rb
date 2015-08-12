require_relative "test_helper"

class TestMerchantRepository < Minitest::Test
  def test_we_can_initialize_merchants
    data = CSV.read "./data/fixtures/merchants.csv",
    headers: true, header_converters: :symbol
    merch_repo = MerchantRepository.new(data)
    assert_equal CSV::Table, merch_repo.merchants.class
  end

  def test_we_can_make_merchant_id_with_table
    data = CSV.read "./data/fixtures/merchants.csv",
    headers: true, header_converters: :symbol
    merch_repo = MerchantRepository.new(data)
    assert_equal 1, merch_repo.make_merchants.first.id
  end

  def test_we_can_make_merchant_name_with_table
    data = CSV.read "./data/fixtures/merchants.csv",
    headers: true, header_converters: :symbol
    merch_repo = MerchantRepository.new(data)
    assert_equal "Schroeder-Jerde", merch_repo.make_merchants.first.name
  end

  def test_we_can_make_merchant_creation_date_with_table
    data = CSV.read "./data/fixtures/merchants.csv",
    headers: true, header_converters: :symbol
    merch_repo = MerchantRepository.new(data)
    assert_equal Date.parse("2012-03-27 14:53:59 UTC"),
                 merch_repo.make_merchants.last.created_at
  end

  def test_we_can_make_merchant_update_time_with_table
    data = CSV.read "./data/fixtures/merchants.csv",
    headers: true, header_converters: :symbol
    merch_repo = MerchantRepository.new(data)
    assert_equal Date.parse("2012-03-27 14:53:59 UTC"),
                 merch_repo.make_merchants.last.updated_at
  end

  def test_all_method
    data = CSV.read "./data/fixtures/merchants.csv",
    headers: true, header_converters: :symbol
    merch_repo = MerchantRepository.new(data)
    assert_equal Merchant, merch_repo.all.first.class
  end

  def test_random_method
    data = CSV.read "./data/fixtures/merchants.csv",
    headers: true, header_converters: :symbol
    merch_repo = MerchantRepository.new(data)
    assert_equal Merchant, merch_repo.random.class
  end

  def test_find_by_id_method
    data = CSV.read "./data/fixtures/merchants.csv",
    headers: true, header_converters: :symbol
    merch_repo = MerchantRepository.new(data)
    assert_equal "Schroeder-Jerde", merch_repo.find_by_id(1).name
  end

  def test_find_by_name_method
    data = CSV.read "./data/fixtures/merchants.csv",
    headers: true, header_converters: :symbol
    merch_repo = MerchantRepository.new(data)
    assert_equal 1, merch_repo.find_by_name("Schroeder-Jerde").id
  end

  def test_find_by_created_at_method
    data = CSV.read "./data/fixtures/merchants.csv",
    headers: true, header_converters: :symbol
    merch_repo = MerchantRepository.new(data)
    date = Date.parse("2012-03-27 14:53:59 UTC")
    assert_equal 1, merch_repo.find_by_created_at(date).id
  end

  def test_find_by_updated_at_method
    data = CSV.read "./data/fixtures/merchants.csv",
    headers: true, header_converters: :symbol
    merch_repo = MerchantRepository.new(data)
    date = Date.parse("2012-03-27 14:53:59 UTC")
    assert_equal 1, merch_repo.find_by_updated_at(date).id
  end

  def test_find_all_by_id_method
    data = CSV.read "./data/fixtures/merchants.csv",
    headers: true, header_converters: :symbol
    merch_repo = MerchantRepository.new(data)
    assert_equal "Klein, Rempel and Jones",
                 merch_repo.find_all_by_id(2).first.name
  end

  def test_find_all_by_name_method
    data = CSV.read "./data/fixtures/merchants.csv",
    headers: true, header_converters: :symbol
    merch_repo = MerchantRepository.new(data)
    assert_equal 1, merch_repo.find_all_by_name("Schroeder-Jerde").first.id
  end

  def test_find_all_by_created_at_method
    data = CSV.read "./data/fixtures/merchants.csv",
    headers: true, header_converters: :symbol
    merch_repo = MerchantRepository.new(data)
    date = Date.parse("2012-03-27 14:53:59 UTC")
    assert_equal 1, merch_repo.find_all_by_created_at(date).first.id
  end

  def test_find_all_by_updated_at_method
    data = CSV.read "./data/fixtures/merchants.csv",
    headers: true, header_converters: :symbol
    merch_repo = MerchantRepository.new(data)
    date = Date.parse("2012-03-27 14:53:59 UTC")
    assert_equal 1,
    merch_repo.find_all_by_updated_at(date).first.id
  end

  def test_find_all_by_updated_at_method
    data = CSV.read "./data/fixtures/merchants.csv",
    headers: true, header_converters: :symbol
    merch_repo = MerchantRepository.new(data)
    date = Date.parse("2012-03-27 14:53:59 UTC")
    assert_equal 1,
    merch_repo.find_all_by_updated_at(date).first.id
  end

  def test_all_transactions_contains_transactions
    engine = SalesEngine.new("./data/fixtures")
    merch_repo = engine.merchant_repository
    assert_equal 1, merch_repo.all_transactions(1).first.id
  end

  def test_most_revenue_method_returns_collection_of_merchants
    engine = SalesEngine.new("./data/fixtures")
    merch_repo = engine.merchant_repository
    assert_equal Merchant, merch_repo.all_merchant_revenues.first.keys.first.class
  end

  def test_all_merchant_revenues_returns_merchants_and_revenues
    engine = SalesEngine.new("./data/fixtures")
    merch_repo = engine.merchant_repository
    assert_equal "Schroeder-Jerde", merch_repo.all_merchant_revenues.first.keys.first.name
    assert_equal Hash, merch_repo.all_merchant_revenues.first.class
  end

  def test_sorted_merchant_revenues_sorts_merchants
    engine = SalesEngine.new("./data/fixtures")
    merch_repo = engine.merchant_repository
    assert_equal "Higgs Boson", merch_repo.sorted_merchant_revenues.first.keys.first.name
    assert_equal "Schroeder-Jerde", merch_repo.sorted_merchant_revenues.last.keys.first.name
  end

  def test_most_revenue_method_returns_correct_merchants
    engine = SalesEngine.new("./data/fixtures")
    merch_repo = engine.merchant_repository
    assert_equal 3, merch_repo.most_revenue(3).count
    assert_equal "Higgs Boson", merch_repo.most_revenue(3).first.name
  end

end