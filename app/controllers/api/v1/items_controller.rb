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

    def destroy
        render json: Item.delete(params[:id])
    end

    def update
        @item = Item.update(params[:id], item_params)
        render :json => {:error =>  "Record Not Found"}.to_json, :status => 404 if !Merchant.find(@item.merchant_id)
        render json: ItemSerializer.new(@item)
    end

    def find
        @items = Item.where("name ilike ?", "%#{params[:name]}%").order(:name)
        render json: ItemSerializer.new(@items)
    end

    def item_params
        params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end
end