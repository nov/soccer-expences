require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  context 'when authenticated' do
    before { controller.authenticate create(:account) }
    it do
      assigns(:current_account).should be_present
      delete :destroy
      assigns(:current_account).should_not be_present
      response.should redirect_to root_path
    end
  end

  context 'when anonymous' do
    it do
      delete :destroy
      response.should redirect_to root_path
    end
  end
end
