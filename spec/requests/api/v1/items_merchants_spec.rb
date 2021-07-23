require 'rails_helper'

RSpec.describe 'Items Merchant' do
    it 'can get the specific merchant for an item' do
        merchant1 = create(:merchant)

        item1 = create(:item, merchant: merchant1)
        item2 = create(:item, merchant: merchant1)
        item3 = create(:item, merchant: merchant1)

        get "/api/v1/items/#{item3.id}/merchant"

        expect(response).to be_successful
    end
end