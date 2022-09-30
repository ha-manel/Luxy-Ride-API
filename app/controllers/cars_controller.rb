class CarsController < ApplicationController
  def index
    render json: { cars: Car.all }
  end

  def show
    @car = Car.find_by(id: params[:id])
    render json: { car: @car}
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

  private

  def car_params
    params.permit(:user_id, :model, :picture, :driver_name)
  end
end
