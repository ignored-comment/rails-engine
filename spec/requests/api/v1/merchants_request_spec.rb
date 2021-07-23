require 'rails_helper'

describe "Merchants API" do
    it "gets a list of all merchants" do
        create_list(:merchant, 50)

        get '/api/v1/merchants'

        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)

        expect(merchants[:data].count).to eq(20)

        merchants[:data].each do |merchant|
            expect(merchant).to have_key(:id)
            expect(merchant[:id]).to be_an(String)

            expect(merchant[:attributes]).to have_key(:name)
            expect(merchant[:attributes][:name]).to be_a(String)
        end
    end

    it 'returns a list of merchants limited to 20 per page' do
        create_list(:merchant, 40)

        get '/api/v1/merchants'

        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)

        expect(merchants[:data].count).to eq(20)
    end

    # need to develop another test for pg2 of search results

    it 'can get a single merchant' do
        id = create(:merchant).id

        get "/api/v1/merchants/#{id}"

        merchant = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(merchant.count).to eq(1)

        expect(merchant[:data]).to have_key(:id)
        expect(merchant[:data][:id]).to be_an(String)

        expect(merchant[:data][:attributes]).to have_key(:name)
        expect(merchant[:data][:attributes][:name]).to be_a(String)
    end

    it 'can find one merchant based on search' do
        merchant1 = Merchant.create(name: "Suzy-Q")
        merchant2 = Merchant.create(name: "Bobette")
        merchant3 = Merchant.create(name: "The Dude, Man")

        search = "Bobette"

        get "/api/v1/merchants/find?name=#{search}"

        expect(response).to be_successful

        merchant = JSON.parse(response.body, symbolize_names: true)
        expect(merchant[:data][:attributes][:name]).to eq("Bobette")
    end


end

