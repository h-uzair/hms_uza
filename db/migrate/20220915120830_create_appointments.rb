class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.text :description
      t.datetime :from
      t.datetime :to
      t.references :doctor
      t.references :patient

      t.timestamps
    end
  end
end
