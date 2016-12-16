class AddContentToNotes < ActiveRecord::Migration[5.0]
  def change
    add_column :notes, :content, :text
  end
end
