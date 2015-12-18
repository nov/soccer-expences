require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:event) { create(:event) }
  let(:current_account) { create(:account) }

  describe 'role-based access control' do
    describe '#show' do
      context 'when authenticated' do
        before { controller.authenticate current_account }

        context 'when pending' do
          it do
            get :show, id: event
            response.should redirect_to dashboard_path
          end
        end

        context 'when viewer' do
          render_views
          before { current_account.approve! }
          it do
            get :show, id: event
            response.should be_success
            response.should_not render_template(partial: 'events/_edit_button')
          end
        end

        context 'when admin' do
          render_views
          before { current_account.adminize! }
          it do
            get :show, id: event
            response.should be_success
            response.should render_template(partial: 'events/_edit_button')
          end
        end
      end

      context 'when anonymous' do
        it do
          get :show, id: event
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
            get :edit, id: event
            response.should redirect_to dashboard_path
          end
        end

        context 'when viewer' do
          before { current_account.approve! }
          it do
            get :edit, id: event
            response.should redirect_to dashboard_path
          end
        end

        context 'when admin' do
          before { current_account.adminize! }
          it do
            get :show, id: event
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
            post :create, event: {
              title: 'some event',
              location: 'somewhere'
            }
            response.should redirect_to event_path(assigns(:event))
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
            put :update, id: event
            response.should redirect_to dashboard_path
          end
        end

        context 'when viewer' do
          before { current_account.approve! }
          it do
            put :update, id: event
            response.should redirect_to dashboard_path
          end
        end

        context 'when admin' do
          before { current_account.adminize! }
          it do
            put :update, id: event, event: {
              title: 'some event',
              location: 'somewhere'
            }
            response.should redirect_to event_path(event)
          end
        end
      end

      context 'when anonymous' do
        it do
          put :update, id: event
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
          post :create, event: {}
        end.to raise_error ActionController::ParameterMissing
      end
    end

    context 'when valid' do
      it do
        post :create, event: {
          title: 'some event',
          location: 'somewhere'
        }
        assigns(:event).should be_persisted
        assigns(:event).title.should == 'some event'
        assigns(:event).location.should == 'somewhere'
        response.should redirect_to event_path(assigns(:event))
      end
    end

    context 'when invalid' do
      it 'should render validation errors' do
        post :create, event: {
          something: :ignored
        }
        assigns(:event).should_not be_persisted
        response.should render_template 'new'
      end
    end
  end

  describe '#update' do
    let(:event) { create(:event) }
    before do
      current_account.adminize!
      controller.authenticate current_account
    end

    context 'when missing required params' do
      it do
        expect do
          put :update, id: event
        end.to raise_error ActionController::ParameterMissing

        expect do
          put :update, id: event, event: {}
        end.to raise_error ActionController::ParameterMissing
      end
    end

    context 'when valid' do
      it do
        put :update, id: event, event: {
          title: 'new title'
        }
        assigns(:event).title.should == 'new title'
        response.should redirect_to event_path(assigns(:event))
      end
    end

    context 'when invalid' do
      it 'should render validation errors' do
        put :update, id: event, event: {
          cost_from_members_budget: -1000
        }
        assigns(:event).reload.cost_from_members_budget.should_not == -1000
        response.should render_template 'edit'
      end
    end
  end
end
