require 'spec_helper'

describe AnswersController do
  let(:question) { create :question }

  login_user

  describe 'POST #create' do

    context 'with valid information' do


      it 'saves new answer in questions.answer' do
        expect { post :create, answer: attributes_for(:answer), question_id: question, user_id: @user, format: :js }.to change(question.answers, :count).by(1)
      end
      it 'saves new answer in @user.answer' do
        expect { post :create, answer: attributes_for(:answer), question_id: question, user_id: @user, format: :js }.to change(@user.answers, :count).by(1)
      end
      it 'stays on question page and renders answer' do
        post :create, answer: attributes_for(:answer), question_id: question, user_id: @user, format: :js
        expect(response).to render_template :create
      end
    end
    context 'with invalid information' do


      it 'doesn\'t save the question' do
        expect { post :create, answer: attributes_for(:invalid_answer), question_id: question, user_id: @user, format: :js }.not_to change(Answer, :count)
      end
      it 'stays on question page' do
        post :create, answer: attributes_for(:invalid_answer), question_id: question, user_id: @user, format: :js
        expect(response).to render_template :create
      end
    end
  end
end
