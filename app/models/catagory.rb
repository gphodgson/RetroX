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
#
#======================
class Catagory < ApplicationRecord
  validates :name, presence: true
end
