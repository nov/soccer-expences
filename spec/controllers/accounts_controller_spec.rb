require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  let(:current_account) { create(:account) }

  describe 'role-based access control' do
    describe '#show' do
      context 'when authenticated' do
        before { controller.authenticate current_account }

        context 'when pending' do
          it do
            get :index
            response.should redirect_to dashboard_path
          end
        end

        context 'when viewer' do
          before { current_account.approve! }
          it do
            get :index
            response.should be_success
          end
        end

        context 'when admin' do
          before { current_account.adminize! }
          it do
            get :index
            response.should be_success
          end
        end
      end

      context 'when anonymous' do
        it do
          get :index
          response.should redirect_to root_path
        end
      end
    end
  end
end
