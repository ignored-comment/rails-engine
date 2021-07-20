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
end

