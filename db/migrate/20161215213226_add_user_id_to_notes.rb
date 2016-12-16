class AddUserIdToNotes < ActiveRecord::Migration[5.0]
  def change
    add_column :notes, :user_id, :integer
    add_index :notes, :user_id
  end
end
