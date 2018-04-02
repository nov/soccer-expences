class CreateEventMembers < ActiveRecord::Migration[4.2]
  def change
    create_table :event_members do |t|
      t.belongs_to :event, :member, null: false
      t.timestamps null: false
      t.index [:event_id, :member_id], unique: true
    end
  end
end
