class Addingtospaces < ActiveRecord::Migration[7.0]
  def change
    add_column :spaces, :date_from, :date
    add_column :spaces, :date_to  , :date
  end
end
