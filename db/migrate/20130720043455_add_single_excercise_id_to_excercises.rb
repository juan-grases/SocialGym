class AddSingleExcerciseIdToExcercises < ActiveRecord::Migration
  def change
    add_column :excercises, :single_excercise_id, :integer
	remove_column :excercises, :name, :string
  end
end
