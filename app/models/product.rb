#======================
# Product
#
# Represents User table in database.
#
# Feilds
# --------------------------
# Name        | String      | Required
# Price       | Decimal     | Requried, Numeric
# Stock       | Integer     | Requried, Numeric, Integer
# Image       | Attachment  | Optional
# Description | Text        | Optional
#
# Assocations
# --------------------
# Belongs to a Catagory
# Has Many OrderedItems
# Has Many Orders via OrderedItems
#
#======================

class Product < ApplicationRecord
  NEW_PRODUCT_THRESHOLD = 3
  RECENT_UPDATE_THRESHOLD = 3

  def self.new_products
    Product.where(new_products_query)
  end

  def self.new_products_query
    "julianday('now') - julianday(created_at) <= #{NEW_PRODUCT_THRESHOLD}"
  end

  def self.recently_updated_products
    Product.where
  end

  def self.recently_updated_products_query
    "julianday('now') - julianday(created_at) <= #{RECENT_UPDATE_THRESHOLD} AND NOT (#{new_products_query})"
  end

  validates :name, :price, :stock, presence: true
  validates :price, numericality: true
  validates :stock, numericality: [only_integer: true]

  belongs_to :catagory
  has_many :ordered_items
  has_many :orders, through: :ordered_items

  has_one_attached :image
end
