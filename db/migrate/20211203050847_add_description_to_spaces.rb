class AddDescriptionToSpaces < ActiveRecord::Migration[6.1]
  def change
    add_column :spaces, :description, :string
  end
end
