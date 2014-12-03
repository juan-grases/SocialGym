class AddRepsToExcercises < ActiveRecord::Migration
  def change
    add_column :excercises, :reps, :integer
  end
end
