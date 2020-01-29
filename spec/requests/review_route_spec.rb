require 'rails_helper'


describe "reviews routes", :type => :request do

  before do
    User.create!({email: "admin@admin.com", password: "admin555"})
    post '/authenticate', params: { :email => "admin@admin.com", :password => "admin555" }
    @token = JSON.parse(response.body)["auth_token"]
    @hd = { :Authorization => @token }
    post '/destinations', params: { :destination => {:name => 'test_name', :country => 'test_country'} }, headers: @hd
    @destination = Destination.find(JSON.parse(response.body)['id'])
    post "/destinations/#{@destination.id}/reviews", params: { :review => {:body_text => 'test_body_text', :raiting => 5, :destination_id => @destination.id.to_i} }, headers: @hd
    @review = Review.find(JSON.parse(response.body)['id'])
  end

  it 'returns the body_text body_text' do
    get "/destinations/#{@destination.id}/reviews", headers: @hd
    expect(JSON.parse(response.body).first['body_text']).to eq('test_body_text')
  end

  it 'returns the destination rating' do
    get "/destinations/#{@destination.id}/reviews", headers: @hd
    expect(JSON.parse(response.body).first['rating']).to eq(5)
  end

  it 'returns a created status' do
    post "/destinations/#{@destination.id}/reviews", params: { :review => {:body_text => 'test_body_text', :raiting => 5, :destination_id => @destination.id.to_i} }, headers: @hd
    expect(response).to have_http_status(:created)
  end

  it 'returns unprocessable entity status when given invalid input' do
    post "/destinations/#{@destination_id}/reviews", params: { :review => {:body_text => 'test_body_text', :rating => 3, :destination_id => 0 } }, headers: @hd
    expect(response).to have_http_status(422)
  end

  it 'deletes a review for a destination' do
    delete "/destinations/#{@destination.id}/reviews/#{@review.id}", headers: @hd
    get "/destinations/#{@destination.id}/reviews", headers: @hd
    expect(JSON.parse(response.body).length).to eq(0)
  end
end
#
# describe "Patch Destinations route", :type => :request do
#
#   before do
#     post '/destinations', params: { :destination => {:name => 'test_name', :country => 'test_country'} }
#     @destination = Destination.find(JSON.parse(response.body)['id'])
#     patch "/destinations/#{@destination.id}", params: { :destination => {:name => 'updated_test_name', :country => 'test_country'} }
#   end
#
#   it 'Patches a destination' do
#     get "/destinations"
#     expect(JSON.parse(response.body).last["name"]).to eq("updated_test_name")
#   end
#
#   it 'returns unprocessable entity status when given invalid input' do
#     get "/destinations"
#     patch "/destinations/#{@destination.id}", params: { :destination => {:name => nil} }
#     expect(response).to have_http_status(422)
#   end
# end
#
# describe "post a destination review", :type => :request do
#
#   before do
#     post '/destinations', params: { :destination => {:name => 'test_name', :country => 'test_country'} }
#     @destination_id = JSON.parse(response.body)['id']
#     post "/destinations/#{@destination_id}/reviews", params: { :review => {:body_text => 'test_body_text', :rating => 3, :destination_id => @destination_id.to_i } }
#   end
#
#
#
# end
#
# describe "get reviews route", :type => :request do
#
#   before do
#     post '/destinations', params: { :destination => {:name => 'test_name', :country => 'test_country'} }
#     @destination = Destination.find(JSON.parse(response.body)['id'])
#     post "/destinations/#{@destination.id}/reviews", params: { :review => {:body_text => 'test_body_text', :raiting => 5, :destination_id => @destination.id.to_i} }
#     @review = Review.find(JSON.parse(response.body)['id'])
#     post "/destinations/#{@destination.id}/reviews", params: { :review => {:body_text => 'sdafdfewrrerwer', :raiting => 3, :destination_id => @destination.id.to_i} }
#     get "/destinations/#{@destination.id}/reviews"
#   end
#
#   it 'returns all reviews for a destination' do
#     expect(JSON.parse(response.body).last['body_text']).to eq('sdafdfewrrerwer')
#   end
#
#   it 'returns a single review for a destination' do
#     get "/destinations/#{@destination.id}/reviews/#{@review.id}"
#     expect(JSON.parse(response.body)['body_text']).to eq('test_body_text')
#   end
#
# end
