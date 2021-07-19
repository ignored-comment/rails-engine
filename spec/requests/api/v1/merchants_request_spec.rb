require 'rails_helper'

describe "Books API" do
    it "gets all merchants, 20 results at a time" do
        get '/api/v1/merchants'

        expect(response).to be_successful
    end
end

