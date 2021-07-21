class Api::V1::ItemsController < ApplicationController
    def index
        per_page = params.fetch(:per_page, 20).to_i
        page = params.fetch(:page, 1).to_i
        page = 1 if page < 1
        @items = Item.all.offset((page - 1) * per_page).limit(per_page)
        render json: ItemSerializer.new(@items)
    end

    def show
        @item = Item.find(params[:id])
        render json: ItemSerializer.new(@item)
    end

    def create
        @item = Item.create(item_params)
        if @item.save
            render json: ItemSerializer.new(@item), status: :created
        else
            render :json => {:error =>  "Unprocessable Entity"}.to_json, :status => 422
        end
    end

    def item_params
        params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end
end