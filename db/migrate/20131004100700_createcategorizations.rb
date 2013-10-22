class Createcategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |c|
      c.integer :video_id
      c.integer :category_id

      c.timestamps
    end
  end
end
