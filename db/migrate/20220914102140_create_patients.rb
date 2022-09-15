class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.string :city
      t.string :username
      t.string :password
      t.text :address

      t.timestamps
    end
  end
end
