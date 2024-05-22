class AddEmailToDoctors < ActiveRecord::Migration[7.0]
  def change
    add_column :doctors, :email, :string
  end
end
