class AddColToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :remember_digest, :String
  end
end
