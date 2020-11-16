#======================
# User
#
# Represents User table in database.
#
# Feilds
# --------------------------
# Name  | String  | Required
# Pass  | String  | Requried
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

  validates :name, :pass, presence: true
end
