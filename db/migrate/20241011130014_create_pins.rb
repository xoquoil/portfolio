class CreatePins < ActiveRecord::Migration[6.1]
  def change
    create_table :pins do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.text :body
      t.decimal :latitude, precision: 10, scale: 6, null: false
      t.decimal :longitude, precision: 10, scale: 6, null: false
      t.string :image
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
