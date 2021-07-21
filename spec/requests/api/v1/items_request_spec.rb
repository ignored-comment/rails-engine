require 'rails_helper'

describe 'Items API', type: :request do
    it 'gets a list of all items' do
        create_list(:item, 5)

        get '/api/v1/items'

        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)

        expect(items[:data].count).to eq(5)

        items[:data].each do |item|
            expect(item).to have_key(:id)
            expect(item[:id]).to be_an(String)

            expect(item[:attributes]).to have_key(:name)
            expect(item[:attributes][:name]).to be_a(String)

            expect(item[:attributes]).to have_key(:description)
            expect(item[:attributes][:description]).to be_a(String)

            expect(item[:attributes]).to have_key(:unit_price)
            expect(item[:attributes][:unit_price]).to be_a(Float)

            expect(item[:attributes]).to have_key(:merchant_id)
            expect(item[:attributes][:merchant_id]).to be_a(Integer)
        end
    end

    it 'returns a list of items limited to 20 per page' do
        create_list(:item, 40)

        get '/api/v1/items'

        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)

        expect(items[:data].count).to eq(20)
    end

    # need to develop another test for pg2 of search results

    it 'can get a single item' do
        id = create(:item).id

        get "/api/v1/items/#{id}"

        item = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(item.count).to eq(1)

        expect(item[:data]).to have_key(:id)
        expect(item[:data][:id]).to be_an(String)

        expect(item[:data][:attributes]).to have_key(:name)
        expect(item[:data][:attributes][:name]).to be_a(String)
    end

    it 'can create a new item' do
        merchant = Merchant.create(name: "Bob's Bobbleheads")
        item_params = {
            "name": "Bobblehead #1",
            "description": "It Bobbles with Its Head",
            "unit_price": 35.00,
            "merchant_id": merchant.id
        }
        headers = {"CONTENT_TYPE" => "application/json"}

        post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)

        new_item = Item.last

        expect(response).to be_successful

        expect(new_item.name).to eq(item_params[:name])
        expect(new_item.description).to eq(item_params[:description])
        expect(new_item.unit_price).to eq(item_params[:unit_price])
        expect(new_item.merchant_id).to eq(item_params[:merchant_id])
    end


    # it 'can create a new item' do
    #     merchant = Merchant.create!(name: "Sauron")
    #     item_params = {
    #       "name": "The One Ring",
    #       "description": "One ring to rule them all",
    #       "unit_price": 100.99,
    #       "merchant_id": merchant.id
    #     }
    #     headers = {"CONTENT_TYPE" => "application/json"}
  
    #     post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)
    #     created_item = Item.last
    #     expect(response).to be_successful
    #     expect(response).to have_http_status(:created)
    #     expect(response.status).to eq(201)
    #     expect(created_item.name).to eq(item_params[:name])
    #     expect(created_item.description).to eq(item_params[:description])
    #     expect(created_item.unit_price).to eq(item_params[:unit_price])
    #     expect(created_item.merchant_id).to eq(merchant.id)
    #   end
end