class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.string :location, null: false
      t.date :date, null: false
      t.timestamps null: false
    end
  end
end
