require 'rails_helper'

RSpec.describe DashboardsController, type: :controller do
  context 'when authenticated' do
    let(:current_account) { create(:account) }
    before { controller.authenticate current_account }

    it do
      get :show
      response.should be_success
    end

    describe '@events' do
      let(:all_events) do
        50.times.collect { create(:event) }
      end

      it 'should lists all events' do
        get :show
        assigns(:events).should match_array all_events
      end
    end

    describe 'role-based access control' do
      render_views

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
  end

  context 'when anonymous' do
    it do
      get :show
      response.should redirect_to root_path
    end
  end
end
