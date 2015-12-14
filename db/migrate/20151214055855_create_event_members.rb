class CreateEventMembers < ActiveRecord::Migration
  def change
    create_table :event_members do |t|
      t.belongs_to :event, :member, null: false
      t.timestamps null: false
    end
    add_index :event_members, [:event_id, :member_id], unique: true
  end
end
