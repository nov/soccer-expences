require 'rails_helper'

RSpec.describe DashboardsController, type: :controller do
  let(:current_account) { create(:account) }

  describe 'role-based access control' do
    describe '#show' do
      context 'when authenticated' do
        render_views
        before { controller.authenticate current_account }

        context 'when pending' do
          it do
            get :show
            response.should_not render_template(partial: 'events/_list')
          end
        end

        context 'when viewer' do
          before { current_account.approve! }
          it do
            get :show
            response.should render_template(partial: 'events/_list')
          end
        end

        context 'when admin' do
          before { current_account.adminize! }
          it do
            get :show
            response.should render_template(partial: 'events/_list')
          end
        end
      end

      context 'when anonymous' do
        it do
          get :show
          response.should redirect_to root_path
        end
      end
    end

    describe '#update' do
      context 'when authenticated' do
        render_views
        before { controller.authenticate current_account }

        context 'when pending' do
          it do
            put :update
            response.should redirect_to dashboard_path
          end
        end

        context 'when viewer' do
          before { current_account.approve! }
          it do
            put :update
            response.should redirect_to members_path
          end
        end

        context 'when admin' do
          before { current_account.adminize! }
          it do
            put :update
            response.should redirect_to members_path
          end
        end
      end

      context 'when anonymous' do
        it do
          get :show
          response.should redirect_to root_path
        end
      end
    end
  end
end
