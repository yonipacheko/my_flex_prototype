class CreateJoinOfCategories < ActiveRecord::Migration
  def change
    create_table :join_of_categories do |c|
      c.integer :video_id
      c.integer :category_id

      c.timestamps
    end
  end
end
