class CreateRentees < ActiveRecord::Migration
  def change
    create_table :rentees do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
