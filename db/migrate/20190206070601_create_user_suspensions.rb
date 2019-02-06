class CreateUserSuspensions < ActiveRecord::Migration[5.2]
  def change
    create_table :user_suspensions do |t|
      t.timestamp :removed_at
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
