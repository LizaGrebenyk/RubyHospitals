class CreateMedicalRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :medical_records do |t|
      t.references :doctor, null: false, foreign_key: true
      t.references :patient, null: false, foreign_key: true
      t.date :date
      t.string :diagnosis
      t.text :treatment

      t.timestamps
    end
  end
end
