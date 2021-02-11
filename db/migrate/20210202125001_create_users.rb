class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email,
               :null   => false,
               :unique => true
      t.string :nickname, 
               :null   => false, 
               :unique => true
      t.integer :phone, 
                :unique => true
      t.string :password_digest
      t.boolean :account_active, 
                :default => false
      t.string :confirm_token
      t.timestamps
    end
  end
end
