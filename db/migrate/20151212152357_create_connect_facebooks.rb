class CreateConnectFacebooks < ActiveRecord::Migration
  def change
    create_table :connect_facebooks do |t|
      t.belongs_to :account
      t.string :identifier, :access_token, null: false
      t.timestamps null: false
      t.index :identifier, unique: true
    end
  end
end
