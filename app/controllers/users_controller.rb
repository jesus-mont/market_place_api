class UsersController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def show
    @user = User.find(params[:id])
    render json: @user.to_json
  end

  private
  def record_not_found
    render json: "Record Not Found", status: :not_found
  end


  # def create
  #     user = User.new(user_params)
  #     if user.save
  #     render json: user, status: 201, location: [:api, user]
  #     else
  #     render json: { errors: user.errors }, status: 422
  #     end
  # end
end
