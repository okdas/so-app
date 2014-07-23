require 'spec_helper'

describe 'Questions API' do
  describe 'GET index' do
    context 'unauthorized' do
      it 'returns 401 code if access token is missing' do
        get '/api/v1/questions/', format: :json
        expect(response.status).to eq 401
      end
      it 'returns 401 code if access token is broken' do
        get '/api/v1/questions/', format: :json, access_token: '12345'
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let!(:user) { create(:user) }
      let!(:first_question) { create(:question) }
      let!(:second_question) { create(:question) }
      let(:access_token) { create(:access_token, resource_owner_id: user.id) }

      before { get '/api/v1/questions/', format: :json, access_token: access_token.token }

      it 'returns 200 code' do
        expect(response.status).to eq 200
      end

      %w(id body title user_id).each do |attr|
        it "returns #{attr} in array of users" do
          expect(response.body).to be_json_eql(first_question.send(attr.to_sym).to_json).at_path("questions/0/#{attr}")
        end
      end

      it 'returns answers count' do
        expect(response.body).to be_json_eql(first_question.answers.count.to_json).at_path('questions/0/answers_count')
      end
    end
  end

  describe 'GET question' do
    context 'unauthorized' do
      let!(:question) { create(:question) }
      it 'returns 401 code if access token is missing' do
        get "/api/v1/questions/#{question.id}", format: :json
        expect(response.status).to eq 401
      end
      it 'returns 401 code if access token is broken' do
        get "/api/v1/questions/#{question.id}", format: :json, access_token: '12345'
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let!(:user) { create(:user) }
      let!(:question) { create(:question) }
      let(:access_token) { create(:access_token, resource_owner_id: user.id) }

      context 'raw question tests' do
        before { get "/api/v1/questions/#{question.id}", format: :json, access_token: access_token.token }

        it 'returns 200 code' do
          expect(response.status).to eq 200
        end

        %w(id body title user_id attachments).each do |attr|
          it "returns #{attr} in array of users" do
            expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("question/#{attr}")
          end
        end
      end

      context 'answers test' do
        let!(:answer) { create(:answer) }

        before { get "/api/v1/questions/#{answer.question.id}", format: :json, access_token: access_token.token }

        it 'returns answers with question' do
          expect(response.body).to be_json_eql(answer.question.answers.to_json).at_path('question/answers')
        end
      end
    end
  end
end