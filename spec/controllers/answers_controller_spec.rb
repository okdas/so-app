require 'spec_helper'

describe AnswersController do
  let(:question) { create :question }
  let(:user) { create :user }
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  describe 'POST #create' do

    context 'with valid information' do
      it 'saves new answer in questions.answer' do
        expect { post :create, answer: attributes_for(:answer), question_id: question, user_id: user }.to change(question.answers, :count).by(1)
      end
      it 'saves new answer in user.answer' do
        expect { post :create, answer: attributes_for(:answer), question_id: question, user_id: user }.to change(user.answers, :count).by(1)
      end
      it 'stays on question page' do
        post :create, answer: attributes_for(:answer), question_id: question, user_id: user
        expect(response).to redirect_to question_path(question)
      end
    end
    context 'with invalid information' do
      it 'doesn\'t save the question' do
        expect { post :create, answer: attributes_for(:invalid_answer), question_id: question, user_id: user }.not_to change(Answer, :count)
      end
      it 'stays on question page' do
        post :create, answer: attributes_for(:invalid_answer), question_id: question, user_id: user
        expect(response).to redirect_to question_path(question)
      end
    end
  end
end
