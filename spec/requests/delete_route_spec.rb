require 'rails_helper'


describe "Delete reviews route", :type => :request do

  before do
    post '/destinations', params: { :destination => {:name => 'test_name', :country => 'test_country'} }
    @destination = Destination.find(JSON.parse(response.body)['id'])
    post "/destinations/#{@destination.id}/reviews", params: { :review => {:body_text => 'test_body_text', :raiting => 5, :destination_id => @destination.id.to_i} }
    @review = Review.find(JSON.parse(response.body)['id'])
    delete "/destinations/#{@destination.id}/reviews/#{@review.id}"
    get "/destinations/#{@destination.id}/reviews"
  end

  it 'Deletes a review for a destination' do
    expect(JSON.parse(response.body).length).to eq(0)
  end
end

describe "Delete Destinations route", :type => :request do

  before do
    post '/destinations', params: { :destination => {:name => 'test_name', :country => 'test_country'} }
    @destination = Destination.find(JSON.parse(response.body)['id'])
    delete "/destinations/#{@destination.id}"
    get "/destinations"
  end

  it 'Deletes a destination' do
    expect(JSON.parse(response.body).length).to eq(0)
  end
end
