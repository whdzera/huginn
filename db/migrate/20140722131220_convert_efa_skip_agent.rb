class ConvertEfaSkipAgent < ActiveRecord::Migration[4.2]
  def up
    say "Skipped conversion of EventFormattingAgent in migration. Run rake huginn:convert_efa_skip_agent after setup."
  end

  def down
    say "Skipped rollback of EventFormattingAgent conversion."
  end
end
