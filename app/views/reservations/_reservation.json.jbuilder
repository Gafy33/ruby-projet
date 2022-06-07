json.extract! reservation, :id, :id_flight, :id_user, :nombre_passage, :class_seat, :statut, :number, :departure_airport, :arrival_airport, :duration, :departure_date, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
