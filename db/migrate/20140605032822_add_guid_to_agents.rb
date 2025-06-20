class AddGuidToAgents < ActiveRecord::Migration[4.2]
  def change
    add_column :agents, :guid, :string

    # Isi kolom guid langsung pakai SQL, lebih cepat dan aman
    reversible do |dir|
      dir.up do
        say_with_time "Mengisi GUID untuk semua agen" do
          execute <<-SQL.squish
            UPDATE agents
            SET guid = md5(random()::text || clock_timestamp()::text)
          SQL
        end

        change_column_null :agents, :guid, false
        add_index :agents, :guid
      end
    end
  end
end
