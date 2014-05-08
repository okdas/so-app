require 'spec_helper'

describe QuestionsController do
  let(:question) { create(:question) }
  let(:questions) { create_list(:question, 2) }
  let(:static_question) { create(:static_question) }
  let(:invalid_question) { create(:invalid_question) }
  let(:user) { create :user }
  before { login_as(user, scope: :user) }


  describe 'GET #index' do

    before { get :index }

    it 'creates an array of questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, id: question }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'creates new Question and assigns it to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end
    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { get :edit, id: question }

    it 'assigns question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders new edit' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid information' do
      it 'saves new question in Question' do
        expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
      end
      it 'redirects to created question' do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid information' do
      it 'does not save new question' do
        expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
      end
      it 'redirects to new view' do
        post :create, question: attributes_for(:invalid_question)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid information' do
      it 'assigns question to @question' do
        patch :update, id: static_question, question: attributes_for(:static_question)
        expect(assigns(:question)).to eq static_question
      end

      it 'updates question in Question' do
        patch :update, id: static_question, question: attributes_for(:static_question)
        static_question.reload
        expect(static_question.title).to eq 'My question number nil'
        expect(static_question.body).to eq 'Donec vestibulum faucibus est, vitae tristique erat sollicitudin vitae.'

      end

      it 'redirects to updated question' do
        patch :update, id: static_question, question: attributes_for(:static_question)
        expect(response).to redirect_to static_question
      end
    end

    context 'with invalid information' do
      before { patch :update, id: static_question, question: attributes_for(:invalid_question) }
      it 'does not change question' do
        static_question.reload
        expect(static_question.title).to eq 'My question number nil'
        expect(static_question.body).to eq 'Donec vestibulum faucibus est, vitae tristique erat sollicitudin vitae.'
      end
      it 'redirects to new view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before { question }

    it 'deletes question' do
      expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
    end

    it 'redirects to index view' do
      delete :destroy, id: question
      expect(response).to redirect_to question_path
    end
  end

end
