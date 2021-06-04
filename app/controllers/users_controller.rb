require 'pry'
class UsersController < ApplicationController
  

  def show
    # binding.pry
    begin
      @user = User.find(params[:id]) 
      rescue ActiveRecord::RecordNotFound => e
        return render json: "#{Rails.root}/public/404", status: :not_found
      raise
    end 
    render json: @user.to_json       
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
