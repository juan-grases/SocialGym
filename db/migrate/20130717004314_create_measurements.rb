class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.integer :weight
      t.integer :height
      t.integer :rightArm
      t.integer :leftArm
      t.integer :back
      t.integer :waits
      t.integer :rightLeg
      t.integer :leftLeg

      t.timestamps
    end
  end
end
