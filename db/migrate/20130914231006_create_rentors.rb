class CreateRentors < ActiveRecord::Migration
  def change
    create_table :rentors do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
