require 'rails_helper'

RSpec.describe IngredientsController, type: :controller do
  let!(:store) { create(:store) }
  let!(:item) { create(:item, store: store) }
  let!(:ingredient) { create(:ingredient, item: item) }
  let(:valid_attributes) { { name: 'New Ingredient', item_id: item.id } }
  let(:invalid_attributes) { { name: '' } }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: { store_id: store.id, item_id: item.id }
      expect(response).to have_http_status(:ok)
    end

    it 'assigns all ingredients as @ingredients' do
      get :index, params: { store_id: store.id, item_id: item.id }
      expect(assigns(:ingredients)).to eq([ingredient])
    end
  end

  describe 'GET #show' do
    context 'when ingredient exists' do
      it 'returns a success response' do
        get :show, params: { store_id: store.id, item_id: item.id, id: ingredient.id }
        expect(response).to have_http_status(:ok)
      end

      it 'assigns the requested ingredient as @ingredient' do
        get :show, params: { store_id: store.id, item_id: item.id, id: ingredient.id }
        expect(assigns(:ingredient)).to eq(ingredient)
      end
    end

    context 'when ingredient does not exist' do
      it 'returns a 404 not found response' do
        get :show, params: { store_id: store.id, item_id: item.id, id: 0 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Ingredient' do
        expect {
          post :create, params: { store_id: store.id, item_id: item.id, ingredient: valid_attributes }
        }.to change(Ingredient, :count).by(1)
      end

      it 'returns a 201 created response' do
        post :create, params: { store_id: store.id, item_id: item.id, ingredient: valid_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'returns a 422 unprocessable entity response' do
        post :create, params: { store_id: store.id, item_id: item.id, ingredient: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested ingredient' do
        put :update, params: { store_id: store.id, item_id: item.id, id: ingredient.id, ingredient: { name: 'Updated Ingredient' } }
        ingredient.reload
        expect(ingredient.name).to eq('Updated Ingredient')
      end

      it 'returns a 200 ok response' do
        put :update, params: { store_id: store.id, item_id: item.id, id: ingredient.id, ingredient: { name: 'Updated Ingredient' } }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      it 'returns a 422 unprocessable entity response' do
        put :update, params: { store_id: store.id, item_id: item.id, id: ingredient.id, ingredient: { name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when the ingredient does not exist' do
      it 'returns a 404 not found response' do
        put :update, params: { store_id: store.id, item_id: item.id, id: 0, ingredient: { name: 'Non-existent Ingredient' } }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested ingredient' do
      expect {
        delete :destroy, params: { store_id: store.id, item_id: item.id, id: ingredient.id }
      }.to change(Ingredient, :count).by(-1)
    end

    it 'returns a 204 no content response' do
      delete :destroy, params: { store_id: store.id, item_id: item.id, id: ingredient.id }
      expect(response).to have_http_status(:no_content)
    end

    context 'when the ingredient does not exist' do
      it 'returns a 404 not found response' do
        delete :destroy, params: { store_id: store.id, item_id: item.id, id: 0 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
