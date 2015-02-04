class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :name
      t.string :oauth_token
      t.datetime :oauth_expires_at
      t.string :completion
      t.string :email
      t.string :uid

      t.timestamps null: false
    end
  end
end
