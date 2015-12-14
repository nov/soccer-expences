class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, :location, null: false
      t.integer :total_cost, default: 0
      t.date :date, null: false
      t.timestamps null: false
    end
  end
end
