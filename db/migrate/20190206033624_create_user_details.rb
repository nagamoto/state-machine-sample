class CreateUserDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :user_details do |t|
      t.string :phone_number
      t.string :name
      t.date :birthday
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
