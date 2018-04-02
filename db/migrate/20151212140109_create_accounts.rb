class CreateAccounts < ActiveRecord::Migration[4.2]
  def change
    create_table :accounts do |t|
      t.boolean :admin, :approved, default: false
      t.string :display_name, :email, null: false
      t.datetime :last_logged_in_at
      t.timestamps null: false
    end
  end
end
