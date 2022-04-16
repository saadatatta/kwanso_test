require 'rails_helper'

RSpec.describe "Registration", type: :request do
  before(:each) do
    @registration_url = "/api/auth"
    @registration_params = {
        email: 'test@gmail.com',
        password: '123456',
        password_confirmation: '123456'
    }
  end

  describe "Email Registration" do
    describe 'POST /api/auth' do
      context "When Registration Params are valid" do
        before(:each) do
          post @registration_url, params: @registration_params
        end

        it "returns status of 200" do
          expect(response).to have_http_status(200)
        end

        it 'returns authentication header with right attributes' do
          expect(response.headers['access-token']).to be_present
        end

        it 'returns client in authentication header' do
          expect(response.headers['client']).to be_present
        end

        it 'returns expiry in authentication header' do
          expect(response.headers['expiry']).to be_present
        end

        it 'returns uid in authentication header' do
          expect(response.headers['uid']).to be_present
        end

        it 'returns status success' do
          parsed_response = JSON.parse(response.body)
          expect(parsed_response['status']).to eq('success')
        end

        it 'creates new user' do
          expect{
            post @registration_url, params: @registration_params.merge({email: "test2@gmail.com"})
          }.to change(User, :count).by(1)
        end
      end

      context 'when signup params is invalid' do
        before { post @registration_url }
        it 'returns unprocessable entity 422' do
          expect(response.status).to eq 422
        end
      end
    end
  end

end