class CreateUserAuthenticationRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :user_authentication_requests do |t|
      t.string :id_image
      t.timestamp :rejected_at
      t.timestamp :authenticated_at
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
