class DropProductsTable < ActiveRecord::Migration
  class DropProductsTable < ActiveRecord::Migration
  def up
    drop_table :rutinas
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
end
