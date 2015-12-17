require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  let(:member) { create(:member) }
  let(:current_account) { create(:account) }

  describe 'role-based access control' do
    describe '#index' do
      context 'when authenticated' do
        before { controller.authenticate current_account }

        context 'when pending' do
          it do
            get :index
            response.should redirect_to dashboard_path
          end
        end

        context 'when viewer' do
          render_views
          before { current_account.approve! }
          it do
            get :index
            response.should be_success
            response.should_not render_template(partial: 'members/_add_button')
          end
        end

        context 'when admin' do
          render_views
          before { current_account.adminize! }
          it do
            get :index
            response.should be_success
            response.should render_template(partial: 'members/_add_button')
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

    describe '#show' do
      context 'when authenticated' do
        before { controller.authenticate current_account }

        context 'when pending' do
          it do
            get :show, id: member
            response.should redirect_to dashboard_path
          end
        end

        context 'when viewer' do
          render_views
          before { current_account.approve! }
          it do
            get :show, id: member
            response.should be_success
            response.should_not render_template(partial: 'members/_edit_button')
          end
        end

        context 'when admin' do
          render_views
          before { current_account.adminize! }
          it do
            get :show, id: member
            response.should be_success
            response.should render_template(partial: 'members/_edit_button')
          end
        end
      end

      context 'when anonymous' do
        it do
          get :show, id: member
          response.should redirect_to root_path
        end
      end
    end

    describe '#new' do
      context 'when authenticated' do
        before { controller.authenticate current_account }

        context 'when pending' do
          it do
            get :new
            response.should redirect_to dashboard_path
          end
        end

        context 'when viewer' do
          before { current_account.approve! }
          it do
            get :new
            response.should redirect_to dashboard_path
          end
        end

        context 'when admin' do
          before { current_account.adminize! }
          it do
            get :new
            response.should be_success
          end
        end
      end

      context 'when anonymous' do
        it do
          get :new
          response.should redirect_to root_path
        end
      end
    end

    describe '#edit' do
      context 'when authenticated' do
        before { controller.authenticate current_account }

        context 'when pending' do
          it do
            get :edit, id: member
            response.should redirect_to dashboard_path
          end
        end

        context 'when viewer' do
          before { current_account.approve! }
          it do
            get :edit, id: member
            response.should redirect_to dashboard_path
          end
        end

        context 'when admin' do
          before { current_account.adminize! }
          it do
            get :show, id: member
            response.should be_success
          end
        end
      end
    end

    describe '#create' do
      context 'when authenticated' do
        before { controller.authenticate current_account }

        context 'when pending' do
          it do
            post :create
            response.should redirect_to dashboard_path
          end
        end

        context 'when viewer' do
          before { current_account.approve! }
          it do
            post :create
            response.should redirect_to dashboard_path
          end
        end

        context 'when admin' do
          before { current_account.adminize! }
          it do
            post :create, member: {display_name: ''}
            response.should be_success
          end
        end
      end

      context 'when anonymous' do
        it do
          post :create
          response.should redirect_to root_path
        end
      end
    end

    describe '#update' do
      context 'when authenticated' do
        before { controller.authenticate current_account }

        context 'when pending' do
          it do
            put :update, id: member
            response.should redirect_to dashboard_path
          end
        end

        context 'when viewer' do
          before { current_account.approve! }
          it do
            put :update, id: member
            response.should redirect_to dashboard_path
          end
        end

        context 'when admin' do
          before { current_account.adminize! }
          it do
            put :update, id: member, member: {display_name: ''}
            response.should be_success
          end
        end
      end

      context 'when anonymous' do
        it do
          put :update, id: member
          response.should redirect_to root_path
        end
      end
    end
  end
end
