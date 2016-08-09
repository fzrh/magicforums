class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.integer :role
      t.string :password_digest
      t.string :password_reset_token
      t.datetime :password_reset_at
      t.timestamps
    end
  end
end
