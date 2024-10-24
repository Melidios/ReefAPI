require 'rails_helper'

RSpec.describe StoresController, type: :controller do
  let!(:store) { create(:store) }
  let(:valid_attributes) { { store: { name: 'New Store', address: '123 Main Street' } } }
  let(:invalid_attributes) { { store: { name: '', address: '' } } }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'assigns all stores as @stores' do
      get :index
      expect(assigns(:stores)).to eq([store])
    end
  end

  describe 'GET #show' do
    context 'when store exists' do
      it 'returns a success response' do
        get :show, params: { id: store.id }
        expect(response).to have_http_status(:ok)
      end

      it 'assigns the requested store as @store' do
        get :show, params: { id: store.id }
        expect(assigns(:store)).to eq(store)
      end
    end

    context 'when store does not exist' do
      it 'returns a 404 not found response' do
        get :show, params: { id: 0 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Store' do
        expect {
          post :create, params: valid_attributes
        }.to change(Store, :count).by(1)
      end

      it 'returns a 201 created response' do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'returns a 422 unprocessable entity response' do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested store' do
        put :update, params: { id: store.id, store: { name: 'Updated Store' } }
        store.reload
        expect(store.name).to eq('Updated Store')
      end

      it 'returns a 200 ok response' do
        put :update, params: { id: store.id, store: { name: 'Updated Store' } }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      it 'returns a 422 unprocessable entity response' do
        put :update, params: { id: store.id, store: { name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when the store does not exist' do
      it 'returns a 404 not found response' do
        put :update, params: { id: 0, store: { name: 'Non-existent Store' } }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested store' do
      expect {
        delete :destroy, params: { id: store.id }
      }.to change(Store, :count).by(-1)
    end

    it 'returns a 204 no content response' do
      delete :destroy, params: { id: store.id }
      expect(response).to have_http_status(:no_content)
    end

    context 'when the store does not exist' do
      it 'returns a 404 not found response' do
        delete :destroy, params: { id: 0 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
