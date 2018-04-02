class CreateConnectGoogles < ActiveRecord::Migration[4.2]
  def change
    create_table :connect_googles do |t|
      t.belongs_to :account
      t.string :identifier, :access_token, null: false
      t.timestamps null: false
      t.index :identifier, unique: true
    end
  end
end
