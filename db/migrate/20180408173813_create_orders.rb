class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :email
      t.integer :quantity
      t.integer :showtime_id

      t.timestamps
    end
  end
end
