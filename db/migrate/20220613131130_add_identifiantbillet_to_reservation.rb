class AddIdentifiantbilletToReservation < ActiveRecord::Migration[7.0]
  def change
      add_column :reservations, :identifiantbillet, :string
  end
end
