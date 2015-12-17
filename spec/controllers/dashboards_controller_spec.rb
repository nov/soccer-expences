require 'rails_helper'

RSpec.describe DashboardsController, type: :controller do
  context 'when authenticated' do
    before { controller.authenticate create(:account) }

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
  end

  context 'when anonymous' do
    it do
      get :show
      response.should redirect_to root_path
    end
  end
end
