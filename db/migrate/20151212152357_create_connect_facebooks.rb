class CreateConnectFacebooks < ActiveRecord::Migration
  def change
    create_table :connect_facebooks do |t|
      t.belongs_to :account
      t.string :identifier
      t.string :access_token
      t.timestamps null: false
    end
    add_index :connect_facebooks, :identifier, unique: true
  end
end
