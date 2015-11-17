class AddImgToItems < ActiveRecord::Migration
  def change
  	add_column :items, :img, :string
  end
end
