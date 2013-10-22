class CreateAnotherCategorizations < ActiveRecord::Migration
  def change
    create_table :another_categorizations do |c|
      c.integer :video_id
      c.integer :category_id

      c.timestamps
    end
  end
end
