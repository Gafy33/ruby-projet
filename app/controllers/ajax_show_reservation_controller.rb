class AjaxShowReservationController < ApplicationController

  def index
  end

  def show
    @flight = Flight.find(params[:id])

    @reservation_eco = Reservation.select('sum(nombre_passage) as total_place').where("id_flight = :flight_id AND class_seat = :class", {flight_id: @flight.id, class: "economique"})
    @reservation_bui = Reservation.select('sum(nombre_passage) as total_place').where("id_flight = :flight_id AND class_seat = :class", {flight_id: @flight.id, class: "affaires"})

    if !@reservation_eco[0]["total_place"]
      @nombre_place_eco = @flight.economy_class_seats;
    else
      @nombre_place_eco = @flight.economy_class_seats - @reservation_eco[0]["total_place"];
    end
    
    if !@reservation_bui[0]["total_place"]
      @nombre_place_bui = @flight.business_class_seats;
    else
      @nombre_place_bui = @flight.business_class_seats - @reservation_bui[0]["total_place"];
    end

    #respond_to do |format|
    #format.html { render json: {data1: @nombre_place_bui, data2: @flight.business_class_seats} }
    #format.json { render json: {data1: @nombre_place_bui, data2: @flight.business_class_seats} }
    #end

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
