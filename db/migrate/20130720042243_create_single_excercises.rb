class CreateSingleExcercises < ActiveRecord::Migration
  def change
    create_table :single_excercises do |t|
	  t.string :name
      t.timestamps
    end
  end
end
