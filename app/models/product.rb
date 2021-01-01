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

  NEW_ID = "1".freeze
  RECENTLY_UPDATED_ID = "2".freeze

  PRICE_ID = "1".freeze
  STOCK_ID = "2".freeze
  NAME_ID =  "3".freeze

  def self.new_products
    Product.where(new_products_query)
  end

  def self.new_products_query
    if Rails.env.development?
      "julianday('now') - julianday(created_at) <= #{NEW_PRODUCT_THRESHOLD}"
    else
      "DATEDIFF('day', current_timestamp, created_at) <= #{NEW_PRODUCT_THRESHOLD}"
    end
  end

  def self.recently_updated_products
    Product.where
  end

  def self.recently_updated_products_query
    if Rails.env.development?
      "julianday('now') - julianday(created_at) <= #{RECENT_UPDATE_THRESHOLD} AND NOT (#{new_products_query})"
    else
      "DATEDIFF('day', current_timestamp, updated_at) <= #{RECENT_UPDATE_THRESHOLD} AND NOT (#{new_products_query})"
    end
  end

  def self.generate_filter_url(params)
    "/products?query=#{params[:query] || ''}&console_id=#{params[:console_id] || ''}&filter_id=#{params[:filter_id] || ''}&page=#{params[:page] || ''}"
  end

  def self.generate_paged_filter_url(params, page)
    "/products?query=#{params[:query] || ''}&console_id=#{params[:console_id] || ''}&filter_id=#{params[:filter_id] || ''}&page=#{page}"
  end

  def self.sort_by(products, sort_id, dir)
    if sort_id.present?
      sort_dir = dir == "0" ? "DESC" : "ASC"
      products = products.order("price #{sort_dir}") if sort_id == PRICE_ID # Sort by Price
      products = products.order("stock #{sort_dir}") if sort_id == STOCK_ID # Sort by Stock
      products = products.order("name #{sort_dir}") if sort_id == NAME_ID   # Sort by Name
    end

    products
  end

  def self.get_filtered_products(params)
    products = Product.all

    products = filter_all_products_by_catagory(products, params[:console_id])

    page = 1
    page = params[:page].to_i if params[:page].present?
    products = get_product_page(products, page)

    products = filter_products(products, params[:filter_id])

    if params[:query].present?
      products = products.where("name LIKE :query", query: "%#{params[:query]}%")
    end

    products = sort_by(products, params[:sort_id], params[:sort_dir])

    products
  end

  def self.filter_products(products, filter_id)
    if filter_id.present?
      if filter_id == NEW_ID # Filter by new Products.
        products = products.where(Product.new_products_query)
      elsif filter_id == RECENTLY_UPDATED_ID # Filter by Recently updated products.
        products = products.where(Product.recently_updated_products_query)
      end
    end

    products
  end

  def self.filter_all_products_by_catagory(products, catagory_id)
    if catagory_id.present?
      catagory = Catagory.find(catagory_id)
      products = catagory.products
    end
    products
  end

  def self.get_product_page(products, page)
    products = products.page(page)
    products
  end

  validates :name, :price, :stock, presence: true
  validates :price, numericality: true
  validates :stock, numericality: [only_integer: true]

  belongs_to :catagory
  has_many :ordered_items
  has_many :orders, through: :ordered_items

  has_one_attached :image

  max_paginates_per 8
end
