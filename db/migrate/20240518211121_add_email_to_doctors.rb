class AddEmailToDoctors < ActiveRecord::Migration[7.0]
  def change
    unless column_exists? :doctors, :email
      add_column :doctors, :email, :string
    end
  end
end
