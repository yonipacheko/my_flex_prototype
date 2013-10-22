class RenameCategoryzationToCategorization < ActiveRecord::Migration
  def up
    rename_table :categorizations, :categorizations
  end

  def down
    rename_table :categorizations, :categorizations
  end
end
