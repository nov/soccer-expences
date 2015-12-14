class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :display_name, null: false
      t.string :description
      t.integer :initial_budget, null: false
      t.float :spent_budget
      t.timestamps null: false
    end
    add_index :members, :display_name, unique: true
  end
end
