require_relative "test_helper"

class TestTransactionRepository < Minitest::Test
  def test_we_can_initialize_transactions
    data = CSV.read "./data/fixtures/transactions.csv",
    headers: true, header_converters: :symbol
    t_repo = TransactionRepository.new(data)
    assert_equal CSV::Table, t_repo.transactions.class
  end

  def test_we_can_make_transaction_id_with_table
    data = CSV.read "./data/fixtures/transactions.csv",
    headers: true, header_converters: :symbol
    t_repo = TransactionRepository.new(data)
    assert_equal 1, t_repo.make_transactions.first.id
  end

  def test_we_can_make_transaction_credit_card_number_with_table
    data = CSV.read "./data/fixtures/transactions.csv",
    headers: true, header_converters: :symbol
    t_repo = TransactionRepository.new(data)
    assert_equal "4654405418249632", t_repo.make_transactions.first.credit_card_number
  end

  def test_we_can_make_transaction_invoice_id_with_table
    data = CSV.read "./data/fixtures/transactions.csv",
    headers: true, header_converters: :symbol
    t_repo = TransactionRepository.new(data)
    assert_equal 1, t_repo.make_transactions.first.invoice_id
  end

  def test_we_can_make_transaction_credit_card_experation_date_with_table
    data = CSV.read "./data/fixtures/transactions.csv",
    headers: true, header_converters: :symbol
    t_repo = TransactionRepository.new(data)
    assert_equal nil, t_repo.all.first.credit_card_expiration_date
  end

  def test_we_can_make_transaction_result_with_table
    data = CSV.read "./data/fixtures/transactions.csv",
    headers: true, header_converters: :symbol
    t_repo = TransactionRepository.new(data)
    assert_equal "success", t_repo.make_transactions.first.result
  end

  def test_we_can_make_transaction_creation_date_with_table
    data = CSV.read "./data/fixtures/transactions.csv",
    headers: true, header_converters: :symbol
    t_repo = TransactionRepository.new(data)
    assert_equal Date.parse("2012-03-27 14:54:09 UTC"), t_repo.make_transactions.last.created_at
  end

  def test_we_can_make_transaction_update_time_with_table
    data = CSV.read "./data/fixtures/transactions.csv",
    headers: true, header_converters: :symbol
    t_repo = TransactionRepository.new(data)
    assert_equal Date.parse("2012-03-27 14:54:09 UTC"), t_repo.make_transactions.last.updated_at
  end

  def test_all_transactions
    data = CSV.read "./data/fixtures/transactions.csv",
    headers: true, header_converters: :symbol
    t_repo = TransactionRepository.new(data)
    assert_equal Transaction, t_repo.all.first.class
  end
  def test_random_method
    data = CSV.read "./data/fixtures/transactions.csv",
    headers: true, header_converters: :symbol
    t_repo = TransactionRepository.new(data)
    assert_equal Transaction, t_repo.random.class
  end

  def test_find_by_id_method
    data = CSV.read "./data/fixtures/transactions.csv",
    headers: true, header_converters: :symbol
    t_repo = TransactionRepository.new(data)
    assert_equal Transaction, t_repo.find_by_id(2).class
  end

  def test_find_by_invoice_id_method
    data = CSV.read "./data/fixtures/transactions.csv",
    headers: true, header_converters: :symbol
    t_repo = TransactionRepository.new(data)
    assert_equal Transaction, t_repo.find_by_invoice_id(1).class
  end

  def test_find_by_credit_card_number_method
    data = CSV.read "./data/fixtures/transactions.csv",
    headers: true, header_converters: :symbol
    t_repo = TransactionRepository.new(data)
    assert_equal Transaction, t_repo.find_by_credit_card_number("4515551623735607").class
  end

  def test_find_by_credit_card_expiration_date_method
    data = CSV.read "./data/fixtures/transactions.csv",
    headers: true, header_converters: :symbol
    t_repo = TransactionRepository.new(data)
    assert_equal Transaction, t_repo.find_by_credit_card_expiration_date(nil).class
  end

  def test_find_by_result_method
    data = CSV.read "./data/fixtures/transactions.csv",
    headers: true, header_converters: :symbol
    t_repo = TransactionRepository.new(data)
    assert_equal Transaction, t_repo.find_by_result("success").class
  end

  def test_find_by_created_at_method
    data = CSV.read "./data/fixtures/transactions.csv",
    headers: true, header_converters: :symbol
    t_repo = TransactionRepository.new(data)
    date = Date.parse("2012-03-27 14:54:10 UTC")
    assert_equal Transaction, t_repo.find_by_created_at(date).class
  end

  def test_find_by_updated_at_method
    data = CSV.read "./data/fixtures/transactions.csv",
    headers: true, header_converters: :symbol
    t_repo = TransactionRepository.new(data)
    date = Date.parse("2012-03-27 14:54:10 UTC")
    assert_equal Transaction, t_repo.find_by_updated_at(date).class
  end

  def test_find_all_by_id_method
    data = CSV.read "./data/fixtures/transactions.csv",
    headers: true, header_converters: :symbol
    t_repo = TransactionRepository.new(data)
    assert_equal Transaction, t_repo.find_all_by_id(2).last.class
  end

  def test_find_all_by_invoice_id_method
    data = CSV.read "./data/fixtures/transactions.csv",
    headers: true, header_converters: :symbol
    t_repo = TransactionRepository.new(data)
    assert_equal Transaction, t_repo.find_all_by_invoice_id(1).first.class
  end

  def test_find_all_by_credit_card_number_method
    data = CSV.read "./data/fixtures/transactions.csv",
    headers: true, header_converters: :symbol
    t_repo = TransactionRepository.new(data)
    assert_equal Transaction, t_repo.find_all_by_credit_card_number("4515551623735607").first.class
  end

  def test_find_all_by_credit_card_expiration_date_method
    data = CSV.read "./data/fixtures/transactions.csv",
    headers: true, header_converters: :symbol
    t_repo = TransactionRepository.new(data)
    assert_equal Transaction, t_repo.find_all_by_credit_card_expiration_date(nil).first.class
  end

  def test_find_all_by_result_method
    data = CSV.read "./data/fixtures/transactions.csv",
    headers: true, header_converters: :symbol
    t_repo = TransactionRepository.new(data)
    assert_equal Transaction, t_repo.find_all_by_result("success").first.class
  end

  def test_find_all_by_created_at_method
    data = CSV.read "./data/fixtures/transactions.csv",
    headers: true, header_converters: :symbol
    t_repo = TransactionRepository.new(data)
    date = Date.parse("2012-03-27 14:54:10 UTC")
    assert_equal Transaction, t_repo.find_all_by_created_at(date).first.class
  end

  def test_find_all_by_updated_at_method
    data = CSV.read "./data/fixtures/transactions.csv",
    headers: true, header_converters: :symbol
    t_repo = TransactionRepository.new(data)
    date = Date.parse("2012-03-27 14:54:10 UTC")
    assert_equal Transaction, t_repo.find_all_by_updated_at(date).first.class
  end
end