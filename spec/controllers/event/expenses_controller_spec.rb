require 'rails_helper'

RSpec.describe Event::ExpensesController, type: :controller do
  let(:current_account) { create(:account) }
  let(:event_context) { create(:event) }

  describe 'role-based access control' do
    describe '#update' do
      context 'when authenticated' do
        before { controller.authenticate current_account }

        context 'when pending' do
          it do
            put :update, params: {event_id: event_context}
            response.should redirect_to dashboard_path
          end
        end

        context 'when viewer' do
          before { current_account.approve! }
          it do
            put :update, params: {event_id: event_context}
            response.should redirect_to dashboard_path
          end
        end

        context 'when admin' do
          before { current_account.adminize! }
          it do
            put :update, params: {event_id: event_context}
            response.should redirect_to event_path(event_context)
          end
        end
      end

      context 'when anonymous' do
        it do
          put :update, params: {event_id: event_context}
          response.should redirect_to root_path
        end
      end
    end
  end
end
