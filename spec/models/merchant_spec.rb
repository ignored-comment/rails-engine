require 'rails_helper'

RSpec.describe Merchant do
    describe 'relationships' do
        it { should have_many(:items) }
    end

    describe 'instance methods' do
        it 'can calculate revenue of a single merchant' do
            
        end
    end
end