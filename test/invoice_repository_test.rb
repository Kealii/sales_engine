require_relative "test_helper"

class TestInvoiceRepository < Minitest::Test
  def test_we_can_initialize_invoices
    data = CSV.read "./data/fixtures/invoices.csv",
    headers: true, header_converters: :symbol
    invoice_repo = InvoiceRepository.new(data)
    assert_equal CSV::Table, invoice_repo.invoices.class
  end

  def test_we_can_make_invoice_id_with_table
    data = CSV.read "./data/fixtures/invoices.csv",
    headers: true, header_converters: :symbol
    invoice_repo = InvoiceRepository.new(data)
    assert_equal "1", invoice_repo.make_invoices.first.id
  end

  def test_we_can_make_invoice_customer_id_with_table
    data = CSV.read "./data/fixtures/invoices.csv",
    headers: true, header_converters: :symbol
    invoice_repo = InvoiceRepository.new(data)
    assert_equal "1", invoice_repo.make_invoices.first.customer_id
  end

  def test_we_can_make_invoice_merchant_id_with_table
    data = CSV.read "./data/fixtures/invoices.csv",
    headers: true, header_converters: :symbol
    invoice_repo = InvoiceRepository.new(data)
    assert_equal "26", invoice_repo.make_invoices.first.merchant_id
  end

  def test_we_can_make_invoice_status_with_table
    data = CSV.read "./data/fixtures/invoices.csv",
    headers: true, header_converters: :symbol
    invoice_repo = InvoiceRepository.new(data)
    assert_equal "shipped", invoice_repo.make_invoices.first.status
  end

  def test_we_can_make_invoice_creation_date_with_table
    data = CSV.read "./data/fixtures/invoices.csv",
    headers: true, header_converters: :symbol
    invoice_repo = InvoiceRepository.new(data)
    assert_equal "2012-03-24 15:54:10 UTC",
    invoice_repo.make_invoices.last.created_at
  end

  def test_we_can_make_invoice_update_time_with_table
    data = CSV.read "./data/fixtures/invoices.csv",
    headers: true, header_converters: :symbol
    invoice_repo = InvoiceRepository.new(data)
    assert_equal "2012-03-24 15:54:10 UTC",
    invoice_repo.make_invoices.last.updated_at
  end

  def test_all_method
    data = CSV.read "./data/fixtures/invoices.csv",
    headers: true, header_converters: :symbol
    invoice_repo = InvoiceRepository.new(data)
    assert_equal '1', invoice_repo.all.first.id
  end

  def test_random_method
    data = CSV.read "./data/fixtures/invoices.csv",
    headers: true, header_converters: :symbol
    invoice_repo = InvoiceRepository.new(data)
    assert_equal Invoice, invoice_repo.random.class
  end

  def test_find_by_id_method
    data = CSV.read "./data/fixtures/invoices.csv",
    headers: true, header_converters: :symbol
    invoice_repo = InvoiceRepository.new(data)
    assert_equal "1", invoice_repo.find_by_id("2").customer_id
  end

  def test_find_by_customer_id_method
    data = CSV.read "./data/fixtures/invoices.csv",
    headers: true, header_converters: :symbol
    invoice_repo = InvoiceRepository.new(data)
    assert_equal "1",
    invoice_repo.find_by_customer_id("1").id
  end

  def test_find_by_merchant_id_method
    data = CSV.read "./data/fixtures/invoices.csv",
    headers: true, header_converters: :symbol
    invoice_repo = InvoiceRepository.new(data)
    assert_equal "1",
    invoice_repo.find_by_merchant_id("26").id
  end

  def test_find_by_status_method
    data = CSV.read "./data/fixtures/invoices.csv",
    headers: true, header_converters: :symbol
    invoice_repo = InvoiceRepository.new(data)
    assert_equal "1", invoice_repo.find_by_status("shipped").id
  end

  def test_find_by_created_at_method
    data = CSV.read "./data/fixtures/invoices.csv",
    headers: true, header_converters: :symbol
    invoice_repo = InvoiceRepository.new(data)
    assert_equal "1",
    invoice_repo.find_by_created_at("2012-03-25 09:54:09 UTC").id
  end

  def test_find_by_updated_at_method
    data = CSV.read "./data/fixtures/invoices.csv",
    headers: true, header_converters: :symbol
    invoice_repo = InvoiceRepository.new(data)
    assert_equal "1",
    invoice_repo.find_by_updated_at("2012-03-25 09:54:09 UTC").id
  end

  def test_find_all_by_id_method
    data = CSV.read "./data/fixtures/invoices.csv",
    headers: true, header_converters: :symbol
    invoice_repo = InvoiceRepository.new(data)
    assert_equal "1",
    invoice_repo.find_all_by_id("2").first.customer_id
  end

  def test_find_all_by_customer_id_method
    data = CSV.read "./data/fixtures/invoices.csv",
    headers: true, header_converters: :symbol
    invoice_repo = InvoiceRepository.new(data)
    assert_equal "1",
    invoice_repo.find_all_by_customer_id("1").first.id
  end

  def test_find_all_by_merchant_id_method
    data = CSV.read "./data/fixtures/invoices.csv",
    headers: true, header_converters: :symbol
    invoice_repo = InvoiceRepository.new(data)
    assert_equal "1",
    invoice_repo.find_all_by_merchant_id("26").first.id
  end

  def test_find_all_by_status_method
    data = CSV.read "./data/fixtures/invoices.csv",
    headers: true, header_converters: :symbol
    invoice_repo = InvoiceRepository.new(data)
    assert_equal "1",
    invoice_repo.find_all_by_status("shipped").first.id
  end

  def test_find_all_by_created_at_method
    data = CSV.read "./data/fixtures/invoices.csv",
    headers: true, header_converters: :symbol
    invoice_repo = InvoiceRepository.new(data)
    assert_equal "1",
    invoice_repo.find_all_by_created_at("2012-03-25 09:54:09 UTC").first.id
  end

  def test_find_all_by_updated_at_method
    data = CSV.read "./data/fixtures/invoices.csv",
    headers: true, header_converters: :symbol
    invoice_repo = InvoiceRepository.new(data)
    assert_equal "1",
    invoice_repo.find_all_by_updated_at("2012-03-25 09:54:09 UTC").first.id
  end

end