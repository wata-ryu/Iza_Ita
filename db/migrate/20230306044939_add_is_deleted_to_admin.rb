class AddIsDeletedToAdmin < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :is_deleted, :boolean
  end
end
