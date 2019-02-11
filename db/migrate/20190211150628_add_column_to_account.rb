class AddColumnToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :status, :integer, default: 0
    add_index :accounts, :status
  end
end
