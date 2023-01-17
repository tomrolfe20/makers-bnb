class AddingUser < ActiveRecord::Migration[7.0]
  def change
# makes a table called "posts"
      # has a column called "text", type is text
      # column "author_name", a string
      # automatically makes created_at and modified_at columns
      create_table :users do |t|
        t.text :user_name
        t.text :email
        t.text :password_digest
        t.timestamps
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
