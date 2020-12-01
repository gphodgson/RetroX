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

  def self.generate_filter_url(params)
    "/products?query=#{params[:query] || ''}&console_id=#{params[:console_id] || ''}&filter_id=#{params[:filter_id] || ''}&page=#{params[:page] || ''}"
  end

  def self.generate_paged_filter_url(params, page)
    "/products?query=#{params[:query] || ''}&console_id=#{params[:console_id] || ''}&filter_id=#{params[:filter_id] || ''}&page=#{page}"
  end

  def self.sort_by(products, sort_id, dir)
    if sort_id.present?
      products.order("price #{dir}") if sort_id == 1
      products.order("stock #{dir}") if sort_id == 2
      products.order("name #{dir}") if sort_id == 3
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

    products = sort_by(products, params[:sort_by], params[:sort_dir])

    products
  end

  def self.filter_products(products, filter_id)
    if filter_id.present?
      if filter_id == "1" # Filter by new Products.
        products = products.where(Product.new_products_query)
      elsif filter_id == "2" # Filter by Recently updated products.
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
