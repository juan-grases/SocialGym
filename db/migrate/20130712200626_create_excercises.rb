class CreateExcercises < ActiveRecord::Migration
  def change
    create_table :excercises do |t|
      t.string :name
      t.integer :series
      t.string :reps
      t.string :integer
      t.string :routine_day_id
      t.string :int

      t.timestamps
    end
  end
end
