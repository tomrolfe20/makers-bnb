class AddingUser < ActiveRecord::Migration[7.0]
  def change
# makes a table called "posts"
      # has a column called "text", type is text
      # column "author_name", a string
      # automatically makes created_at and modified_at columns
      create_table :users do |t|
        t.text :user_name
        t.text :email
        t.text :password
        t.timestamps
    end
  end
end
