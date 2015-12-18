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
            post :create, member: {display_name: 'some member'}
            response.should redirect_to member_path(assigns(:member))
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

  describe '#create' do
    before do
      current_account.adminize!
      controller.authenticate current_account
    end

    context 'when missing required params' do
      it do
        expect do
          post :create
        end.to raise_error ActionController::ParameterMissing

        expect do
          post :create, member: {}
        end.to raise_error ActionController::ParameterMissing
      end
    end

    context 'when valid' do
      it do
        post :create, member: {
          display_name: 'someone'
        }
        assigns(:member).should be_persisted
        assigns(:member).display_name.should == 'someone'
        response.should redirect_to member_path(assigns(:member))
      end
    end

    context 'when invalid' do
      it 'should render validation errors' do
        post :create, member: {
          something: :ignored
        }
        assigns(:member).should_not be_persisted
        response.should render_template 'new'
      end
    end
  end

  describe '#update' do
    let(:member) { create(:member) }
    before do
      current_account.adminize!
      controller.authenticate current_account
    end

    context 'when missing required params' do
      it do
        expect do
          put :update, id: member
        end.to raise_error ActionController::ParameterMissing

        expect do
          put :update, id: member, member: {}
        end.to raise_error ActionController::ParameterMissing
      end
    end

    context 'when valid' do
      it do
        put :update, id: member, member: {
          display_name: 'new name'
        }
        assigns(:member).display_name.should == 'new name'
        response.should redirect_to member_path(assigns(:member))
      end
    end

    context 'when invalid' do
      it 'should render validation errors' do
        put :update, id: member, member: {
          initial_budget: -1000
        }
        assigns(:member).reload.initial_budget.should_not == -1000
        response.should render_template 'edit'
      end
    end
  end
end
