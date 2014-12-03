class RemoveDescriptionFromRoutineDays < ActiveRecord::Migration
  def up
    remove_column :routine_days, :description
  end

  def down
    add_column :routine_days, :descrption, :text
  end
end
