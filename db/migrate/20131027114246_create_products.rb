class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :image_url
      t.decimal :price, precision: 8, scale: 2			# price of type decimal.  8 significant figures. 2 digits after the decimal point

      t.timestamps
    end
  end
end
