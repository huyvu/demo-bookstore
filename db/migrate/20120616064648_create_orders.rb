class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :address
      t.integer :phone

      t.timestamps
    end
  end
end
