class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at,
              :transaction_repository

  def initialize(id,
                 invoice_id,
                 credit_card_number,
                 credit_card_experation_date,
                 result,
                 created_at,
                 updated_at,
                 transaction_repository = "")
    @id = id.to_i
    @invoice_id = invoice_id.to_i
    @credit_card_number = credit_card_number
    @credit_card_expiration_date = credit_card_expiration_date
    @result = result
    @created_at = created_at
    @updated_at = updated_at
    @transaction_repository = transaction_repository
  end

  def invoice
    transaction_repository.find_invoices_by_invoice_id(invoice_id)
  end

  def success?
    result == "success" ? true : false
  end
end