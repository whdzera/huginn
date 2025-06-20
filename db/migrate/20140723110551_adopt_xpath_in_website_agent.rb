class AdoptXpathInWebsiteAgent < ActiveRecord::Migration[4.2]
  def up
    say "Skipped WebsiteAgent XPath adoption. Please run `rake huginn:adopt_xpath_in_website_agent` manually."
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "Cannot revert this migration"
  end
end
