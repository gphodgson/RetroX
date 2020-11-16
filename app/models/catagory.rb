#======================
# Catagory
#
# Represents Catagory table in database.
#
# Feilds
# --------------------------
# Name  | String  | Required
#
# Assocations
# --------------------
# Has Many Products
#
#======================
class Catagory < ApplicationRecord
  validates :name, presence: true
  has_many :products
end
