class AddTypeOptionAttributeToPushbulletAgents < ActiveRecord::Migration[4.2]
   def up
    say "Skipped"
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "Cannot revert this migration"
  end
end
