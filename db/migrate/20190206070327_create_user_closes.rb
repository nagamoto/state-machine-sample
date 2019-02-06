class CreateUserCloses < ActiveRecord::Migration[5.2]
  def change
    create_table :user_closes do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
