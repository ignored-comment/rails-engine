class Api::V1::ItemsController < ApplicationController
    def index
        per_page = params.fetch(:per_page, 20).to_i
        page = params.fetch(:page, 1).to_i
        page = 1 if page < 1
        @items = Item.all.offset((page - 1) * per_page).limit(per_page)
        render json: ItemSerializer.new(@items)
    end
end