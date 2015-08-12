require "date"
class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :item_repository

  def initialize(id,
                 name,
                 description,
                 unit_price,
                 merchant_id,
                 created_at,
                 updated_at,
                 item_repository = "")

    @id          = id.to_i
    @name        = name
    @description = description
    @unit_price  = BigDecimal.new(unit_price)/100
    @merchant_id = merchant_id.to_i
    @created_at  = Date.parse(created_at)
    @updated_at  = Date.parse(updated_at)
    @item_repository   = item_repository
  end

  def invoice_items
    item_repository.find_all_invoice_items_by_item_id(id)
  end

  def merchant
    item_repository.find_merchant_by_merchant_id(merchant_id)
  end
end