class AddingSpacesTable < ActiveRecord::Migration[7.0]
  def change
      create_table :spaces do |s|
        s.text :name
        s.text :description
        s.integer :price_per_night
        s.integer :user_id
        s.text :host_name
      end
  end
end
