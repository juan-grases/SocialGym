class ChangeExcercises < ActiveRecord::Migration
  def up
	remove_column :excercises, :routine_day_id, :string
	remove_column :excercises, :integer, :string
	remove_column :excercises, :int, :string
	remove_column :excercises, :reps, :string
	add_column :excercises, :reps, :integer
	add_column :excercises, :routine_day_id, :integer
	remove_column :excercises, :reps, :string
	
  end

  def down
  end
end
