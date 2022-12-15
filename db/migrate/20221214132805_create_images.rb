class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.text :image_data
      t.references :gallery, null: false, foreign_key: true

      t.timestamps
    end
  end
end
