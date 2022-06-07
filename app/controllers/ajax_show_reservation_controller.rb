class AjaxShowReservationController < ApplicationController

  def index
  end

  def show
    @flight = Flight.find(params[:id])

    @reservation_eco = Reservation.where("id_flight = :flight_id AND class_seat = :class", {flight_id: @flight.id, class: "economique"}).count
    @reservation_bui = Reservation.where("id_flight = :flight_id AND class_seat = :class", {flight_id: @flight.id, class: "affaires"}).count

    @nombre_place_eco = @flight.economy_class_seats - @reservation_eco;
    @nombre_place_bui = @flight.business_class_seats - @reservation_bui;

    @date = @flight.departure_date

    @date_depart = @date.strftime("%H:%M")
    @date_arrive = (@date + @flight.duration.minutes).strftime("%H:%M")
    @date_jour = @date.strftime("%d/%m/%Y");

    respond_to do |format|

      format.html { render json: {all_data: {data: @flight}, data1: @date_jour, data2: @date_arrive,data3: @date_depart, data4: @nombre_place_eco, data5: @nombre_place_bui} }
      format.json { render json: {all_data: {data: @flight}, data1: @date_jour, data2: @date_arrive,data3: @date_depart, data4: @nombre_place_eco, data5: @nombre_place_bui} }

    end
  end
end
