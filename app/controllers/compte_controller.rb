class CompteController < ApplicationController
  def index
    @reservations = Reservation.select('reservations.id, reservations.statut, reservations.class_seat, reservations.nombre_passage, datetime(flights.departure_date) as departure_date, flights.departure_airport, flights.arrival_airport, flights.number, flights.duration')
                               .joins("INNER JOIN flights ON flights.id = reservations.id_flight")
                               .where(id_user: current_user.id)

    @count = Reservation.where(id_user: current_user.id).count
  end
end
