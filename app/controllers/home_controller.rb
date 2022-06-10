class HomeController < ApplicationController

  def index
    @flights = Flight.page(params[:page]).per(10)

    if user_signed_in?
      @nombre_reservations_attente = Reservation.where("id_user = :user_id AND statut = :statu", {user_id: current_user.id, statu: "en attente"}).count
    end

  end

  def showairport
    if user_signed_in?
      @nombre_reservations_attente = Reservation.where("id_user = :user_id AND statut = :statu", {user_id: current_user.id, statu: "en attente"}).count
    end

    if params[:arrival_airport] == ""
      @flights = Flight.where("departure_airport = :departure", {departure: params[:departure_airport]}).page(params[:page]).per(10)
    elsif params[:departure_airport] == ""
      @flights = Flight.where("arrival_airport = :arrival", {arrival: params[:arrival_airport]}).page(params[:page]).per(10)
    else
      @flights = Flight.where("departure_airport = :departure AND arrival_airport = :arrival", {departure: params[:departure_airport], arrival: params[:arrival_airport]}).page(params[:page]).per(10)
    end

  end
end
