class CreateAttendees < ActiveRecord::Migration[6.1]
  def change
    create_table :attendees do |t|
      t.integer :user_id
      t.integer :event_id
      t.string :status

      t.timestamps
    end
  end
end
