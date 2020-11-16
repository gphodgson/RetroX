#======================
# OrderedItem
#
# Represents OrderedItem table in database.
#
# Feilds
# --------------------------
# Price   | Decimal | Requried, Numeric
# Amount  | Integer | Requried, Numeric, Integer
#
# Assocations
# --------------------
# Belongs to a Product
# Belongs to an Order
# Serves as a connetion between Product & Order
#
#======================
class OrderedItem < ApplicationRecord
  validates :price, :amount, presence: true
  validates :price, numericality: true
  validates :amount, numericality: [only_integer: true]

  belongs_to :product
  belongs_to :order
end
