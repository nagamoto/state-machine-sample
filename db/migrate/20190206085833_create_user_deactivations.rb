class CreateUserDeactivations < ActiveRecord::Migration[5.2]
  def change
    create_table :user_deactivations do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
