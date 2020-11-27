#======================
# User
#
# Represents User table in database.
#
# Feilds
# --------------------------
# Name  | String  | Required
#
# Assocations
# --------------------
# Has Many Addresses
# Has Many Orders
#
#======================
class User < ApplicationRecord
  has_many :addresses
  has_many :orders

  validates :name, presence: true

  has_secure_password
end
