require 'spec_helper'

describe CategoriesController do
  let(:dummy_category) { Category.new(name: 'Web', id: 77) }

  describe 'POST #create' do
    let(:category_form_params) do
      {
        format: :json,
        'app_id' => 77,
        'category' =>
          {
            'name' => 'Web'
          }
      }
    end

    before do
      allow(Category).to receive(:find).and_return(dummy_category)
      allow(Category).to receive(:create).and_return(dummy_category)
    end

    it 'creates the category' do
      expect(Category).to receive(:create).with(app_id: '77', name: 'Web')
      post :create, category_form_params
    end

    it 'renders json response when format is json' do
      post :create, category_form_params
      expect(response.status).to eq 201
      expect(response.body).to eql dummy_category.to_json
    end
  end

  describe 'PUT #update' do
    let(:attributes) do
      {
        'category' => {
          'name' => 'Web',
          'id' => '77'
        }
      }
    end

    before do
      allow(Category).to receive(:find).and_return(dummy_category)
      allow(dummy_category).to receive(:save)
    end

    it 'retrieves the category to be updated' do
      expect(Category).to receive(:find).with('77', params: { app_id: '2' })
      patch :update, category: attributes, app_id: '2', id: '77', format: :json
    end

    it 'writes the attributes' do
      expect(dummy_category).to receive(:write_attributes).with(attributes)
      patch :update, app_id: '2', id: '77', category: attributes, format: :json
    end

    it 'saves the record' do
      expect(dummy_category).to receive(:save)
      patch :update, app_id: '2', id: '77', category: attributes, format: :json
    end
  end

  describe 'DELETE #destroy' do
    before do
      allow(Category).to receive(:find).and_return(dummy_category)
      allow(dummy_category).to receive(:destroy)
    end

    it 'retrieves the category to be updated' do
      expect(Category).to receive(:find).with('77', params: { app_id: '2' })
      delete :destroy, app_id: '2', id: '77', format: :json
    end

    it 'destroys the record' do
      expect(dummy_category).to receive(:destroy)
      delete :destroy, app_id: '2', id: '77', format: :json

    end
  end
end
