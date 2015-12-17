require 'rails_helper'

RSpec.describe TopController, type: :controller do
  context 'when authenticated' do
    before { controller.authenticate create(:account) }
    it do
      get :index
      expect(response).to redirect_to dashboard_path
    end
  end

  context 'when anonymous' do
    it do
      get :index
      expect(response).to be_success
    end
  end
end
