class MigrateAgentsToLiquidTemplating < ActiveRecord::Migration[4.2]
  def up
    say "Liquid migration skipped. Please run `rake huginn:migrate_to_liquid` after setup."
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "Cannot revert migration to Liquid templating"
  end
end
