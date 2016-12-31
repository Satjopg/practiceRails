class AddIndexeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_index :users, :mail, unique: true
  end
end
