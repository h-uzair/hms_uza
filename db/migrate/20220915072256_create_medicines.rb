class CreateMedicines < ActiveRecord::Migration[7.0]
  def change
    create_table :medicines do |t|
      t.string :name
      t.text :description
      t.string :medicine_type

      t.timestamps
    end
  end
end
