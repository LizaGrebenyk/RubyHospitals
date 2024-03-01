class CreateDoctors < ActiveRecord::Migration[7.1]
  def change
    create_table :doctors do |t|
      t.references :hospital, null: false, foreign_key: true
      t.string :name
      t.string :specialization
      t.string :phone_number

      t.timestamps
    end
  end
end
