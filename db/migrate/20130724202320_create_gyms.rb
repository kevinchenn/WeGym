class CreateGyms < ActiveRecord::Migration
  def change
    create_table :gyms do |t|
      t.string :owner
      t.string :email
      t.string :password_hash
      t.string :gym
      t.string :price
      t.string :period
      t.string :wepay_access_token
      t.integer :wepay_account_id
      t.string :plan

      t.timestamps
    end
  end
end
