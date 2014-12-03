class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.boolean :complete
      t.string :name
      t.integer :user_id
		
      t.timestamps
    end
  end
end
