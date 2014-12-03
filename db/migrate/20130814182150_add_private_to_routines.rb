class AddPrivateToRoutines < ActiveRecord::Migration
  def change
    add_column :routines, :private, :boolean
  end
end
