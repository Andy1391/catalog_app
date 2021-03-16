class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :phone
      t.string :adress
      t.string :email
      t.decimal :total_price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
