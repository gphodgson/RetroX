#======================
# Address
#
# Represents Address table in database.
#
# Feilds
# --------------------------
# Line 1      | String  | Required
# Line 2      | String  |
# City        | String  | Requried
# State       | String  | Requried
# Country     | String  | Requried
# Phone       | String  | Requried
# Postal Code | String  | Requried
#
# Assocations
# --------------------
# Has One User
#
#======================
class Address < ApplicationRecord
  def address_string
    "#{line1}, #{line2}, #{city}, #{state}, #{country}, #{postalCode}"
  end

  validates :line1, :city, :state, :country, :phone, :postalCode, presence: true
  validates :state, inclusion: { in: ["AB", "BC", "MB", "NB", "NL", "NS", "ON", "PE", "QC", "SK"] }

  belongs_to :user, optional: true
end
