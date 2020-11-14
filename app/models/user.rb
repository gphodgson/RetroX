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
#
#======================
class User < ApplicationRecord
  has_many :addresses

  validates :name, :pass, presence: true
end
