require 'spec_helper'

describe 'Profiles API' do
  describe 'Resource owner profile' do
    context 'unauthorized' do
      it 'returns 401 code if access token is missing' do
        get '/api/v1/profiles/me', format: :json
        expect(response.status).to eq 401
      end
      it 'returns 401 code if access token is broken' do
        get '/api/v1/profiles/me', format: :json, access_token: '12345'
        expect(response.status).to eq 401
      end
    end
    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles/me', format: :json, access_token: access_token.token }

      it 'returns 200 code' do
        expect(response.status).to eq 200
      end

      %w(id email).each do |attr|
        it "returns user #{attr}" do
          expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path(attr)
        end
      end

      %w(password encrypted_password).each do |attr|
        it "doesn't return user #{attr}" do
          expect(response.body).to_not have_json_path(attr)
        end
      end
    end
  end

  describe 'All profiles' do
    context 'unauthorized' do
      it 'returns 401 code if access token is missing' do
        get '/api/v1/profiles', format: :json
        expect(response.status).to eq 401
      end
      it 'returns 401 code if access token is broken' do
        get '/api/v1/profiles', format: :json, access_token: '12345'
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let!(:first_user) { create(:user) }
      let!(:second_user) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: first_user.id) }

      before { get '/api/v1/profiles/', format: :json, access_token: access_token.token }

      it 'returns 200 code' do
        expect(response.status).to eq 200
      end

      %w(id name level).each do |attr|
        it "returns #{attr} in array of users" do
          expect(response.body).to be_json_eql(first_user.send(attr.to_sym).to_json).at_path("0/#{attr}")
        end
      end

      %w(password encrypted_password).each do |attr|
        it "doesn't return users #{attr}" do
          expect(response.body).to_not have_json_path(attr)
        end
      end
    end
  end
end