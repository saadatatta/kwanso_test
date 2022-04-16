class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.string :name, null: false
      t.string :card_number, null: false
      t.date :expiration_date, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
