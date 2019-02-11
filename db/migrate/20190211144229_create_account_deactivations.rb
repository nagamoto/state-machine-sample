class CreateAccountDeactivations < ActiveRecord::Migration[5.2]
  def change
    create_table :account_deactivations do |t|
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
