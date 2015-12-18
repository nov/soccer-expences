require 'rails_helper'

RSpec.describe Event::MembersController, type: :controller do
  let(:current_account) { create(:account) }
  let(:event_context) { create(:event) }
  let(:member_context) { create(:member) }

  describe 'role-based access control' do
    describe '#index' do
      context 'when authenticated' do
        before { controller.authenticate current_account }

        context 'when pending' do
          it do
            get :index, event_id: event_context
            response.should redirect_to dashboard_path
          end
        end

        context 'when viewer' do
          before { current_account.approve! }
          it do
            get :index, event_id: event_context
            response.should be_success
            response.content_type.should == 'application/json'
          end
        end

        context 'when admin' do
          before { current_account.adminize! }
          it do
            get :index, event_id: event_context
            response.should be_success
            response.content_type.should == 'application/json'
          end
        end
      end

      context 'when anonymous' do
        it do
          get :index, event_id: event_context
          response.should redirect_to root_path
        end
      end
    end

    describe '#update' do
      context 'when authenticated' do
        before { controller.authenticate current_account }

        context 'when pending' do
          it do
            put :update, event_id: event_context, id: member_context
            response.should redirect_to dashboard_path
          end
        end

        context 'when viewer' do
          before { current_account.approve! }
          it do
            put :update, event_id: event_context, id: member_context
            response.should redirect_to dashboard_path
          end
        end

        context 'when admin' do
          before { current_account.adminize! }
          it do
            put :update, event_id: event_context, id: member_context
            response.should be_success
            response.content_type.should == 'application/json'
          end
        end
      end

      context 'when anonymous' do
        it do
          put :update, event_id: event_context, id: member_context
          response.should redirect_to root_path
        end
      end
    end
  end

  describe '#update' do
    before do
      current_account.adminize!
      controller.authenticate current_account
    end

    context 'when attending' do
      before do
        event_context.members << member_context
      end

      it 'should remove attendee' do
        put :update, event_id: event_context, id: member_context
        event_context.reload.members.should_not include member_context
      end
    end

    context 'otherwise' do
      it 'should add attendee' do
        put :update, event_id: event_context, id: member_context
        event_context.reload.members.should include member_context
      end
    end
  end
end
