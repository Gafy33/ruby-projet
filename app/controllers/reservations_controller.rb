class ReservationsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  before_action :set_reservation, only: %i[ show edit update destroy ]

  # GET /reservations or /reservations.json
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1 or /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
  end

  def create

    @random = SecureRandom.alphanumeric(6)

    if Reservation.select('identifiantbillet').where("identifiantbillet = :billet", {billet: @random}).exists?
      @random = SecureRandom.alphanumeric(6)
    end

    @reservation = Reservation.new(:id_flight => params[:id], :id_user => current_user.id, :nombre_passage => params[:nombre_passage], :class_seat => params[:class_seat], :statut => "en attente", :identifiantbillet => @random)

    @user = User.find(current_user.id)
    ReservationMailer.with(user: @user, billet: @random).welcome_email.deliver_later

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to home_index_path, notice: "Un email vous a été envoyé pour valider la réservation" }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to reservation_url(@reservation), notice: "Reservation was successfully updated." }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to compte_index_path, notice: "La réservation à été annulée" }
      format.json { head :no_content }
    end
  end

  def confirmation
    @reservation = Reservation.where("identifiantbillet = :billet", {billet: params[:id_billet]}).take

    if @reservation.id_user == current_user.id
        @reservation.update(:statut => "Valide")

        @statut_confirmation = true
        respond_to do |format|
          format.html { render 'reservations/confirmation', notice: "La réservation à bien été validée" }
          format.json { render @statut_confirmation }
        end
    else
        @statut_confirmation = false

        respond_to do |format|
          format.html { render 'reservations/confirmation' }
          format.json { render @statut_confirmation }
        end
    end


  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:id_flight, :id_user, :nombre_passage, :class_seat, :statut)
    end
end
