require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let!(:store) { create(:store) }
  let!(:item) { create(:item, store: store) }
  let(:valid_attributes) { { name: 'New Item', price: 9.99, store_id: store.id } }
  let(:invalid_attributes) { { name: '', price: nil } }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'assigns all items as @items' do
      get :index
      expect(assigns(:items)).to eq([item])
    end

    context 'when filtering by store' do
      it 'returns items belonging to the specified store' do
        get :index, params: { store_id: store.id }
        expect(assigns(:items)).to eq([item])
      end
    end

    context 'when searching by name' do
      it 'returns items matching the search term' do
        get :index, params: { name: 'New' }
        expect(assigns(:items)).to eq([])
      end
    end
  end

  describe 'GET #show' do
    context 'when item exists' do
      it 'returns a success response' do
        get :show, params: { id: item.id }
        expect(response).to have_http_status(:ok)
      end

      it 'assigns the requested item as @item' do
        get :show, params: { id: item.id }
        expect(assigns(:item)).to eq(item)
      end
    end

    context 'when item does not exist' do
      it 'returns a 404 not found response' do
        get :show, params: { id: 0 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Item' do
        expect {
          post :create, params: { item: valid_attributes }
        }.to change(Item, :count).by(1)
      end

      it 'returns a 201 created response' do
        post :create, params: { item: valid_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'returns a 422 unprocessable entity response' do
        post :create, params: { item: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested item' do
        put :update, params: { id: item.id, item: { name: 'Updated Item' } }
        item.reload
        expect(item.name).to eq('Updated Item')
      end

      it 'returns a 200 ok response' do
        put :update, params: { id: item.id, item: { name: 'Updated Item' } }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      it 'returns a 422 unprocessable entity response' do
        put :update, params: { id: item.id, item: { name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when the item does not exist' do
      it 'returns a 404 not found response' do
        put :update, params: { id: 0, item: { name: 'Non-existent Item' } }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested item' do
      expect {
        delete :destroy, params: { id: item.id }
      }.to change(Item, :count).by(-1)
    end

    it 'returns a 204 no content response' do
      delete :destroy, params: { id: item.id }
      expect(response).to have_http_status(:no_content)
    end

    context 'when the item does not exist' do
      it 'returns a 404 not found response' do
        delete :destroy, params: { id: 0 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
