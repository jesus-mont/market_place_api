class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title
      t.decimal :price
      t.boolean :published
      t.integer :user_id

      t.timestamps
    end
    add_index :products, :user_id
  end
end
