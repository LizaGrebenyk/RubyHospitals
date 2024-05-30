class AddUserIdToPatients < ActiveRecord::Migration[6.1]
  def change
    add_column :patients, :user_id, :integer
    add_index :patients, :user_id
  end
end
