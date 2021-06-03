class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
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
