require 'rails_helper'

describe "get destinations route", :type => :request do

  before do
    post '/destinations', params: { :destination => {:name => 'test_name', :country => 'test_country'} }
    @destination = Destination.find(JSON.parse(response.body)['id'])
    get '/destinations'
  end

  it 'returns the all destinations' do
    expect(JSON.parse(response.body).last['name']).to eq('test_name')
  end

  it 'returns a single destination' do
    get "/destinations/#{@destination.id}"
    expect(JSON.parse(response.body)['country']).to eq('test_country')
  end

end

describe "get reviews route", :type => :request do

  before do
    post '/destinations', params: { :destination => {:name => 'test_name', :country => 'test_country'} }
    @destination = Destination.find(JSON.parse(response.body)['id'])
    post "/destinations/#{@destination.id}/reviews", params: { :review => {:body_text => 'test_body_text', :raiting => 5, :destination_id => @destination.id.to_i} }
    @review = Review.find(JSON.parse(response.body)['id'])
    post "/destinations/#{@destination.id}/reviews", params: { :review => {:body_text => 'sdafdfewrrerwer', :raiting => 3, :destination_id => @destination.id.to_i} }
    get "/destinations/#{@destination.id}/reviews"
  end

  it 'returns all reviews for a destination' do
    expect(JSON.parse(response.body).last['body_text']).to eq('sdafdfewrrerwer')
  end

  it 'returns a single review for a destination' do
    get "/destinations/#{@destination.id}/reviews/#{@review.id}"
    expect(JSON.parse(response.body)['body_text']).to eq('test_body_text')
  end

end
