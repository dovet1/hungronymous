class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_restaurant, only: [:edit, :update, :show, :destroy]

  def index
    @restaurants = policy_scope(Restaurant).all
  end

  def new
    @restaurant = Restaurant.new
    authorize @restaurant
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user
    authorize @restaurant
    if @restaurant.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    authorize @restaurant
  end

  def update
    if @restaurant.update(restaurant_params)
      authorize @restaurant
      redirect_to restaurants_path
    else
      render :edit
    end
  end

  def destroy
    @restaurant.destroy
    authorize @restaurant
    redirect_to restaurants_path
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :stars, :review)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

end
