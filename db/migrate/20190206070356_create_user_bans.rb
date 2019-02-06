class CreateUserBans < ActiveRecord::Migration[5.2]
  def change
    create_table :user_bans do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
