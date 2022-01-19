class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :brand
      t.integer :count
      t.string :tag
      t.string :category
      t.float :weight
      t.string :produced_by
      t.string :produced_in

      t.timestamps
    end
  end
end
