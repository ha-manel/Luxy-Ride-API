class CarsController < ApplicationController
  def index
    render json: { cars: Car.all }
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      render json: { success: 'The car has been created successfully' }
    else
      render json: { error: 'There was an error, please try again!' }
    end
  end

  def delete
    @car = Car.find(params[:id])
    if @car.destroy!
      render json: { success: 'The car has been deleted successfully' }
    else
      render json: { error: 'There was an error, please try again!' }
    end
  end

  def reserve
    @reserved_cars = Reservation.where(date: params[:date]).distinct.pluck(:car_id)
    @cars = Car.all
    @cars = @cars.reject { |car| @reserved_cars.include?(car.id) } unless @reserved_cars.empty?
    render json: { cars: @cars }
  end

  private

  def car_params
    params.permit(:user_id, :model, :picture, :driver_name)
  end
end
