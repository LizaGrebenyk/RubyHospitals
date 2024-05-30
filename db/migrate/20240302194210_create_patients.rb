class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
      t.string :name
      t.string :gender
      t.date :date_of_birth

      t.timestamps
    end
  end
end
