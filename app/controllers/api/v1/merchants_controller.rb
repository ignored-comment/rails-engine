class Api::V1::MerchantsController < ApplicationController
    def index
        per_page = params.fetch(:per_page, 20).to_i
        page = params.fetch(:page, 1).to_i
        page = 1 if page < 1
        @merchants = Merchant.all.offset((page - 1) * per_page).limit(per_page)
        render json: MerchantSerializer.new(@merchants)
    end

    def show
        @merchant = Merchant.find(params[:id])
        render json: MerchantSerializer.new(@merchant)
    end
end