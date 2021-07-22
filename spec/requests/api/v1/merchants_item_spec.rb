require 'rails_helper'

RSpec.describe 'Merchant Items Spec' do
    describe 'happy path' do
        it 'can get all the items for each merchant id' do
            merchant1 = create(:merchant)
            merchant2 = create(:merchant)

            item1 = create(:item, merchant: merchant1)
            item2 = create(:item, merchant: merchant1)
            item3 = create(:item, merchant: merchant1)
            item4 = create(:item, merchant: merchant2)
            
            get "/api/v1/merchants/#{merchant1.id}/items"

            expect(response).to be_successful
        end
    end
end