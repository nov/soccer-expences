require 'rails_helper'

RSpec.describe Account::ViewersController, type: :controller do
  let(:current_account) { create(:account) }
  let(:account_context) { create(:account) }

  describe 'role-based access control' do
    describe '#create' do
      context 'when authenticated' do
        before { controller.authenticate current_account }

        context 'when pending' do
          it do
            post :create, account_id: account_context
            account_context.reload.should_not be_approved
            response.should redirect_to dashboard_path
          end
        end

        context 'when viewer' do
          before { current_account.approve! }
          it do
            post :create, account_id: account_context
            account_context.reload.should_not be_approved
            response.should redirect_to dashboard_path
          end
        end

        context 'when admin' do
          before { current_account.adminize! }
          it do
            post :create, account_id: account_context
            account_context.reload.should be_approved
            response.should redirect_to accounts_path
          end
        end
      end

      context 'when anonymous' do
        it do
          post :create, account_id: account_context
          response.should redirect_to root_path
        end
      end
    end
  end
end
