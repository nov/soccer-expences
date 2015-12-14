class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, :location, null: false
      t.integer :cost_from_members_budget, :cost_from_team_budget, :event_members_count, default: 0
      t.date :date, null: false
      t.timestamps null: false
    end
  end
end
