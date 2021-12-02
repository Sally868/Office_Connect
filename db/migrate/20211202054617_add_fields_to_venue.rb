class AddFieldsToVenue < ActiveRecord::Migration[6.1]
  def change
    add_column :venues, :street, :string
    add_column :venues, :suburb, :string
    add_column :venues, :state, :string
    add_column :venues, :country, :string
  end
end
