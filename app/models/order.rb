require "net/http"
require "json"

#======================
# Order
#
# Represents Order table in database.
#
# Feilds
# --------------------------
# Total Price | Decimal | Required, Numeric
# State       | String  | Requried
#
# Assocations
# --------------------
# Belongs to a User
# Has One Address
# Has Many OrderedItems
# Has Many Products via OrderedItems
#
#======================

class Order < ApplicationRecord
  NEW = "new".freeze
  PROCESSING = "processing".freeze
  SHIPPED = "shipped".freeze
  DELIVERED = "delivered".freeze
  CANCELLED = "cancelled".freeze

  def item_string
    "#{products.first.name}, and more..."
  end

  def tax_resource
    tax_url = "https://api.salestaxapi.ca/v2/province/#{address.state}"
    tax_uri = URI(tax_url)
    JSON.parse(Net::HTTP.get(tax_uri))
  end

  def gst
    tax_res = tax_resource

    total_price * tax_res["gst"]
  end

  def pst
    tax_res = tax_resource
    total_price * tax_res["pst"]
  end

  def total_taxed_price
    tax_res = tax_resource
    gst = total_price * tax_res["gst"]
    pst = total_price * tax_res["pst"]
    total_price + gst + pst
  end

  validates :total_price, :state, presence: true
  validates :total_price, numericality: true

  belongs_to :user, optional: true
  belongs_to :address
  has_many :ordered_items
  has_many :products, through: :ordered_items
end
