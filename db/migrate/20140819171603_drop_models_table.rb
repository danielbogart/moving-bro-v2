class DropModelsTable < ActiveRecord::Migration
  def up
    drop_table :models
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end