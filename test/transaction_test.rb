require_relative "test_helper"

class TestTransaction < Minitest::Test
  def test_transaction_has_id
    transaction = Transaction.new("4", "535", "1", "3", "2196", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC")
    assert_equal "4", transaction.id
  end

  def test_transaction_has_credit_card_number
    transaction = Transaction.new("4", "535", "1", "3", "2196", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC")
    assert_equal "1", transaction.credit_card_number
  end

  def test_transaction_has_invoice_id
    transaction = Transaction.new("4", "535", "1", "3", "2196", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC")
    assert_equal "535", transaction.invoice_id
  end

  def test_transaction_has_credit_card_expiration_date
    transaction = Transaction.new("4", "535", "1", "3", "2196", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC")
    assert_equal nil, transaction.credit_card_expiration_date
  end

  def test_transaction_has_result
    transaction = Transaction.new("4", "535", "1", "3", "2196", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC")
    assert_equal "2196", transaction.result
  end

  def test_transaction_has_creation_date
    transaction = Transaction.new("4", "535", "1", "3", "2196", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC")
    assert_equal "2012-03-27 14:54:09 UTC", transaction.created_at
  end

  def test_transaction_has_updated_date
    transaction = Transaction.new("4", "535", "1", "3", "2196", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC")
    assert_equal "2012-03-27 14:54:09 UTC", transaction.updated_at
  end

  def test_invocie_method
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    t_repo = engine.transaction_repository
    transaction = Transaction.new("4", "1", "1", "3", "2196", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC", t_repo)
    assert_equal Invoice, transaction.invoice.class
  end

  def test_invocie_method_returns_nil_if_no_matches
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    t_repo = engine.transaction_repository
    transaction = Transaction.new("4", "777", "1", "3", "2196", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC", t_repo)
    assert_equal nil, transaction.invoice
  end

  def test_success_method_returns_true_for_successful_transactions
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    t_repo = engine.transaction_repository
    transaction = Transaction.new("4",
                                  "5",
                                  "4515551623735607",
                                  nil,
                                  "success",
                                  "2012-03-27 14:54:10 UTC",
                                  "2012-03-27 14:54:10 UTC",
                                  t_repo)
    assert_equal true, transaction.success?
  end

  def test_success_method_returns_false_for_unsuccessful_transactions
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    t_repo = engine.transaction_repository
    transaction = Transaction.new("4",
                                  "5",
                                  "4515551623735607",
                                  nil,
                                  "failed",
                                  "2012-03-27 14:54:10 UTC",
                                  "2012-03-27 14:54:10 UTC",
                                  t_repo)
    assert_equal false, transaction.success?
  end
end