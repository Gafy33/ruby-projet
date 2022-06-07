class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.integer :id_flight
      t.integer :id_user
      t.integer :nombre_passage
      t.string :class_seat
      t.string :statut

      t.timestamps
    end
  end
end
