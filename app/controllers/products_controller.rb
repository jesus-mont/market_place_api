class ProductsController < ApplicationController
    before_action :set_product, only: [:show]
    before_action :authenticate_with_token!, only: [:create, :update, :destroy]

    def index
        render json: Product.all.to_json
    end

    def show
        render json: @product.to_json
    end

    def create
        product = current_user.products.build(product_params)
        if product.save
          render json: product, status: 201, location: [product]
        else
          render json: { errors: product.errors }, status: 422
        end
    end

    def update
        product = current_user.products.find(params[:id])
        if product.update(product_params)
          render json: product, status: 200, location: [product]
        else
          render json: { errors: product.errors }, status: 422
        end
    end

    def destroy
        product = current_user.products.find(params[:id])
        product.destroy
        head 204
    end


    private 
    def set_product
        @product = Product.find(params[:id])
    end

    def product_params
        params.require(:product).permit(:title, :price, :published)
      end
end
