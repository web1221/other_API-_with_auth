require 'rails_helper'


describe "Patch review route", :type => :request do

  before do
    post '/destinations', params: { :destination => {:name => 'test_name', :country => 'test_country'} }
    @destination = Destination.find(JSON.parse(response.body)['id'])
    post "/destinations/#{@destination.id}/reviews", params: { :review => {:body_text => 'test_body_text', :raiting => 5, :destination_id => @destination.id.to_i} }
    @review = Review.find(JSON.parse(response.body)['id'])
    patch "/destinations/#{@destination.id}/reviews/#{@review.id}", params: { :review => {:body_text => 'updated_body_text', :raiting => 5, :destination_id => @destination.id.to_i} }
    get "/destinations/#{@destination.id}/reviews"
  end

  it 'Updates a review for a destination' do
    expect(JSON.parse(response.body).last["body_text"]).to eq("updated_body_text")
  end

  it 'returns unprocessable entity status when given invalid input' do
    patch "/destinations/#{@destination.id}/reviews/#{@review.id}", params: { :review => {:body_text => 'test_body_text', :rating => nil, :destination_id => 0 } }
    expect(response).to have_http_status(422)
  end
end

describe "Patch Destinations route", :type => :request do

  before do
    post '/destinations', params: { :destination => {:name => 'test_name', :country => 'test_country'} }
    @destination = Destination.find(JSON.parse(response.body)['id'])
    patch "/destinations/#{@destination.id}", params: { :destination => {:name => 'updated_test_name', :country => 'test_country'} }
    get "/destinations"
  end

  it 'Patches a destination' do
    expect(JSON.parse(response.body).last["name"]).to eq("updated_test_name")
  end

  it 'returns unprocessable entity status when given invalid input' do
    patch "/destinations/#{@destination.id}", params: { :destination => {:name => nil} }
    expect(response).to have_http_status(422)
  end
end
