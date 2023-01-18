class AddingUser< ActiveRecord::Migration[7.0]
  def change
      create_table :users do |t|
        t.text :email
        t.text :password_digest
        t.text :user_name
        t.timestamps
    end
      create_table :spaces do |s|
        s.text :name
        s.text :description
        s.integer :price_per_night
        s.belongs_to :user, foreign_key: true
    end
      create_table :bookings do |b|
        b.date :date
        b.boolean :available
        b.belongs_to :user, foreign_key: true
        b.belongs_to :space, foreign_key: true
      end 
  end
end


# password needs digest to use bcrypt

# rake db:create_migration (adding_spaces_table)

# use underscores and no capital letters

# run rake db:migrate to update your schema

#  require 'bcrypt' to use password encrypter in seed data

# User.create(
#   first_name: "orhan",
# )
