# require 'rails_helper'
#
# describe "post a destination route", :type => :request do
#
#   before do
#     post '/destinations', params: { :destination => {:name => 'test_name', :country => 'test_country'} }
#   end
#
#   it 'returns the name name' do
#     expect(JSON.parse(response.body)['name']).to eq('test_name')
#   end
#
#   it 'returns the destination country' do
#     expect(JSON.parse(response.body)['country']).to eq('test_country')
#   end
#
#   it 'returns a created status' do
#     expect(response).to have_http_status(:created)
#   end
#
#   it 'returns unprocessable entity status when given invalid input' do
#     post "/destinations", params: { :destination => {:name => false} }
#     expect(response).to have_http_status(422)
#   end
#
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
#   it 'returns the body_text body_text' do
#     expect(JSON.parse(response.body)['body_text']).to eq('test_body_text')
#   end
#
#   it 'returns the destination rating' do
#     expect(JSON.parse(response.body)['rating']).to eq(3)
#   end
#
#   it 'returns a created status' do
#     expect(response).to have_http_status(:created)
#   end
#
#   it 'returns unprocessable entity status when given invalid input' do
#     post "/destinations/#{@destination_id}/reviews", params: { :review => {:body_text => 'test_body_text', :rating => 3, :destination_id => 0 } }
#     expect(response).to have_http_status(422)
#   end
#
# end
