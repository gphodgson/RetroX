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
#
#======================
class User < ApplicationRecord
  validates :name, :pass, presence: true
end
