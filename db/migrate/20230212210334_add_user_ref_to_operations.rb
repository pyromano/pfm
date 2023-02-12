class AddUserRefToOperations < ActiveRecord::Migration[7.0]
  def change
    add_reference :operations, :user, foreign_key: true
  end
end
