class CreateSpaces < ActiveRecord::Migration[6.1]
  def change
    create_table :spaces do |t|
      t.string :name
      t.integer :capacity
      t.references :venue, null: false, foreign_key: true

      t.timestamps
    end
  end
end
