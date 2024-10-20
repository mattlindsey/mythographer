require 'rails_helper'

RSpec.describe MythologiesController, type: :controller do
  let(:valid_attributes) {
    { name: 'Greek', description: 'Greek mythology' }
  }

  let(:invalid_attributes) {
    { name: '', description: '' }
  }

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Mythology' do
        expect {
          post :create, params: { mythology: valid_attributes }
        }.to change(Mythology, :count).by(1)
      end

      it 'redirects to the created mythology' do
        post :create, params: { mythology: valid_attributes }
        expect(response).to redirect_to(mythologies_path)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e., to display the "new" template)' do
        post :create, params: { mythology: invalid_attributes }
        expect(response).to be_unprocessable
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      mythology = Mythology.create! valid_attributes
      get :edit, params: { id: mythology.to_param }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { name: 'Roman', description: 'Roman mythology' }
      }

      it 'updates the requested mythology' do
        mythology = Mythology.create! valid_attributes
        put :update, params: { id: mythology.to_param, mythology: new_attributes }
        mythology.reload
        expect(mythology.name).to eq('Roman')
        expect(mythology.description).to eq('Roman mythology')
      end

      it 'redirects to the mythology' do
        mythology = Mythology.create! valid_attributes
        put :update, params: { id: mythology.to_param, mythology: valid_attributes }
        expect(response).to redirect_to(mythologies_path)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e., to display the "edit" template)' do
        mythology = Mythology.create! valid_attributes
        put :update, params: { id: mythology.to_param, mythology: invalid_attributes }
        expect(response).to be_unprocessable
      end
    end
  end
end
