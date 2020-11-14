class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :line1
      t.string :line2
      t.string :city
      t.string :state
      t.string :country
      t.string :phone
      t.string :postalCode
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
