class CreateRoutineDays < ActiveRecord::Migration
  def change
    create_table :routine_days do |t|
      t.text :cardio_information
      t.text :description
      t.integer :routine_id

      t.timestamps
    end
  end
end
