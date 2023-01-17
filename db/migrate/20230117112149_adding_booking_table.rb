class AddingBookingTable < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |b|
      b.date :date
      b.integer :space_id
      b.boolean :available
  end
  end
end
