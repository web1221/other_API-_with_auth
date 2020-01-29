# require 'rails_helper'
#
#
# describe "Delete reviews route", :type => :request do
#
#   before do
#     User.create!({email: "admin@admin.com", password: "admin555"})
#     post '/authenticate', params: { :email => "admin@admin.com", :password => "admin555" }
#     @token = JSON.parse(response.body)["auth_token"]
#     @hd = { :Authorization => @token }
#     post '/destinations', params: { :destination => {:name => 'test_name', :country => 'test_country'} }, headers: @hd
#     binding.pry
#     @destination = Destination.find(JSON.parse(response.body)['id'])
#     post "/destinations/#{@destination.id}/reviews", params: { :review => {:body_text => 'test_body_text', :raiting => 5, :destination_id => @destination.id.to_i} }, headers: @hd
#     @review = Review.find(JSON.parse(response.body)['id'])
#     delete "/destinations/#{@destination.id}/reviews/#{@review.id}", headers: @hd
#     get "/destinations/#{@destination.id}/reviews", headers: @hd
#   end
#
#   it 'Deletes a review for a destination' do
#     expect(JSON.parse(response.body).length).to eq(0)
#   end
# end
#
# describe "Delete Destinations route", :type => :request do
#
#   before do
#     post '/destinations', params: { :destination => {:name => 'test_name', :country => 'test_country'} }, headers: @hd
#     @destination = Destination.find(JSON.parse(response.body)['id'])
#     delete "/destinations/#{@destination.id}", headers: @hd
#     get "/destinations", headers: @hd
#   end
#
#   it 'Deletes a destination' do
#     expect(JSON.parse(response.body).length).to eq(0)
#   end
# end
