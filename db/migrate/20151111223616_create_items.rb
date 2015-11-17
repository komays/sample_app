class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.text :store
      t.text :name
      t.float :price
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :items, [:user_id, :created_at]
  end
end
