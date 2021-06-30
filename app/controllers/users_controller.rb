class UsersController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :set_user, only: [:show, :update, :destroy]
  # before_action :authenticate_with_token!, only: [:update]

  def show
    render json: @user.to_json
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201
    else 
      render json: { errors: user.errors }, status: 422
    end    
  end

  def update
    @user = current_user
    if @user.update(user_params)
      render json: @user, status: 200
    else
      render json: { errors: @user.errors }, status: 422
    end
  end  

  def destroy
    @user.destroy
    head 204
  end  

  private
  def record_not_found
    render json: "Record Not Found", status: :not_found
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :phone)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
