class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations_1 do |c|
      c.integer :video_id
      c.integer :category_id

      c.timestamps
    end
  end
end
