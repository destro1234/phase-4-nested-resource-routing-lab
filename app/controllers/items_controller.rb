class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response


  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else 
    items = Item.all
    end
    render json: items, include: :user
  end

  def show
    item = Item.find_by!(id: params[:id])
    render json: item
  end

  def create
    new_item = Item.create(item_params)
    render json: new_item, status: :created
  end

  # if params[:dog_house_id]
  #   dog_house = DogHouse.find(params[:dog_house_id])
  #   reviews = dog_house.reviews
  # else
  #   reviews = Review.all
  # end
  # render json: reviews, include: :dog_house

  private
  def render_not_found_response(exception)
    render json: { error: "#{exception.model} not found" }, status: :not_found
  end

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end
end
