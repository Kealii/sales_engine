require_relative "test_helper"

class TestCustomerRepository < Minitest::Test
  def test_we_can_initialize_customers
    data = CSV.read "./data/fixtures/customers.csv",
    headers: true, header_converters: :symbol
    customer_repo = CustomerRepository.new(data)
    assert_equal CSV::Table, customer_repo.customers.class
  end

  def test_we_can_make_customer_id_with_table
    data = CSV.read "./data/fixtures/customers.csv",
    headers: true, header_converters: :symbol
    customer_repo = CustomerRepository.new(data)
    assert_equal "1", customer_repo.make_customers.first.id
  end

  def test_we_can_make_customer_customer_id_with_table
    data = CSV.read "./data/fixtures/customers.csv",
    headers: true, header_converters: :symbol
    customer_repo = CustomerRepository.new(data)
    assert_equal "Joey", customer_repo.make_customers.first.first_name
  end

  def test_we_can_make_customer_merchant_id_with_table
    data = CSV.read "./data/fixtures/customers.csv",
    headers: true, header_converters: :symbol
    customer_repo = CustomerRepository.new(data)
    assert_equal "Ondricka", customer_repo.make_customers.first.last_name
  end

  def test_we_can_make_customer_creation_date_with_table
    data = CSV.read "./data/fixtures/customers.csv",
    headers: true, header_converters: :symbol
    customer_repo = CustomerRepository.new(data)
    assert_equal "2012-03-27 14:54:10 UTC",
    customer_repo.make_customers.last.created_at
  end

  def test_we_can_make_customer_update_time_with_table
    data = CSV.read "./data/fixtures/customers.csv",
    headers: true, header_converters: :symbol
    customer_repo = CustomerRepository.new(data)
    assert_equal "2012-03-27 14:54:10 UTC",
    customer_repo.make_customers.last.updated_at
  end

  def test_all_method
    data = CSV.read "./data/fixtures/customers.csv",
    headers: true, header_converters: :symbol
    customer_repo = CustomerRepository.new(data)
    assert_equal '1', customer_repo.all.first.id
  end

  def test_random_method
    data = CSV.read "./data/fixtures/customers.csv",
    headers: true, header_converters: :symbol
    customer_repo = CustomerRepository.new(data)
    assert_equal Customer, customer_repo.random.class
  end

  def test_find_by_id_method
    data = CSV.read "./data/fixtures/customers.csv",
    headers: true, header_converters: :symbol
    customer_repo = CustomerRepository.new(data)
    assert_equal "Joey", customer_repo.find_by_id("1").first_name
  end

  def test_find_by_first_name_method
    data = CSV.read "./data/fixtures/customers.csv",
    headers: true, header_converters: :symbol
    customer_repo = CustomerRepository.new(data)
    assert_equal "1",
    customer_repo.find_by_first_name("Joey").id
  end

  def test_find_by_last_name_method
    data = CSV.read "./data/fixtures/customers.csv",
    headers: true, header_converters: :symbol
    customer_repo = CustomerRepository.new(data)
    assert_equal "1",
    customer_repo.find_by_last_name("Ondricka").id
  end

  def test_find_by_created_at_method
    data = CSV.read "./data/fixtures/customers.csv",
    headers: true, header_converters: :symbol
    customer_repo = CustomerRepository.new(data)
    assert_equal "1",
    customer_repo.find_by_created_at("2012-03-27 14:54:09 UTC").id
  end

  def test_find_by_updated_at_method
    data = CSV.read "./data/fixtures/customers.csv",
    headers: true, header_converters: :symbol
    customer_repo = CustomerRepository.new(data)
    assert_equal "1",
    customer_repo.find_by_updated_at("2012-03-27 14:54:09 UTC").id
  end

  def test_find_all_by_id_method
    data = CSV.read "./data/fixtures/customers.csv",
    headers: true, header_converters: :symbol
    customer_repo = CustomerRepository.new(data)
    assert_equal "Joey",
    customer_repo.find_all_by_id("1").first.first_name
  end

  def test_find_all_by_first_name_method
    data = CSV.read "./data/fixtures/customers.csv",
    headers: true, header_converters: :symbol
    customer_repo = CustomerRepository.new(data)
    assert_equal "1",
    customer_repo.find_all_by_first_name("Joey").first.id
  end

  def test_find_all_by_last_name_method
    data = CSV.read "./data/fixtures/customers.csv",
    headers: true, header_converters: :symbol
    customer_repo = CustomerRepository.new(data)
    assert_equal "1",
    customer_repo.find_all_by_last_name("Ondricka").first.id
  end

  def test_find_all_by_created_at_method
    data = CSV.read "./data/fixtures/customers.csv",
    headers: true, header_converters: :symbol
    customer_repo = CustomerRepository.new(data)
    assert_equal "1",
    customer_repo.find_all_by_created_at("2012-03-27 14:54:09 UTC").first.id
  end

  def test_find_all_by_updated_at_method
    data = CSV.read "./data/fixtures/customers.csv",
    headers: true, header_converters: :symbol
    customer_repo = CustomerRepository.new(data)
    assert_equal "1",
    customer_repo.find_all_by_updated_at("2012-03-27 14:54:09 UTC").first.id
  end

end