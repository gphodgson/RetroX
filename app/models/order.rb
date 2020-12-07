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

  validates :total_price, :state, presence: true
  validates :total_price, numericality: true

  belongs_to :user, optional: true
  belongs_to :address
  has_many :ordered_items
  has_many :products, through: :ordered_items
end
