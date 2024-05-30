class CreateHospitals < ActiveRecord::Migration[7.0]
  def change
    create_table :hospitals do |t|
      t.string :title
      t.string :country
      t.string :city
      t.string :telephone

      t.timestamps
    end
  end
end
