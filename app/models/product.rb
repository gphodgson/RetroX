#======================
# Product
#
# Represents User table in database.
#
# Feilds
# --------------------------
# Name    | String      | Required
# Price   | Decimal     | Requried, Numeric
# Stock   | Integer     | Requried, Numeric, Integer
# Image   | Attachment  | Optional
#
# Assocations
# --------------------
# Belongs to a Catagory
# Has Many OrderedItems
# Has Many Orders via OrderedItems
#
#======================

class Product < ApplicationRecord
  vaildates :name, :price, :stock, presence: true
  validates :price, numericality: true
  vaidates :stock, numericality: [only_integer: true]

  belongs_to :catagory
  has_many :ordered_items
  has_many :orders, through: :ordered_items

  has_one_attached :image
end
