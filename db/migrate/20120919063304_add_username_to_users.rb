class AddUsernameToUsers < ActiveRecord::Migration[4.2]
  def up
    add_column :users, :username, :string

    execute <<-SQL
      UPDATE users
      SET username = regexp_replace(email, '@.*$', '')
    SQL

    change_column :users, :username, :string, null: false

    add_index :users, :username, unique: true
  end

  def down
    remove_column :users, :username
  end
end
