class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :uid
      t.string :provider
      t.string :access_token
      t.string :expire
      t.string :name
      t.string :secret

      t.timestamps null: false
    end
  end
end
