class CreateEventMembers < ActiveRecord::Migration
  def change
    create_table :event_members do |t|

      t.timestamps null: false
    end
  end
end
