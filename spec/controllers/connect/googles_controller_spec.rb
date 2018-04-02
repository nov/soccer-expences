require 'rails_helper'

RSpec.describe Connect::GooglesController, type: :controller do
  describe '#create' do
    context 'with code' do
      let(:code) { 'code-received-via-js' }
      let(:op_config) { Connect::Google.client }

      before do
        mock_google :post, op_config.token_endpoint, 'access_token', params: {
          grant_type: 'authorization_code',
          code: code,
          redirect_uri: 'postmessage'
        }
      end

      context 'when new user' do
        context 'with email & profile scope' do
          it 'should register user' do
            mock_google :get, op_config.userinfo_endpoint, 'userinfo', access_token: 'access_token' do
              post :create, params: {code: code}
              response.should redirect_to dashboard_path
            end
          end
        end

        context 'without email scope' do
          it 'should register user' do
            mock_google :get, op_config.userinfo_endpoint, 'userinfo_without_email', access_token: 'access_token' do
              post :create, params: {code: code}
              flash[:warning].should == 'Google Login Failed'
              response.should redirect_to root_path
            end
          end
        end

        context 'without profile scope' do
          it 'should register user' do
            mock_google :get, op_config.userinfo_endpoint, 'userinfo_without_profile', access_token: 'access_token' do
              post :create, params: {code: code}
              flash[:warning].should == 'Google Login Failed'
              response.should redirect_to root_path
            end
          end
        end
      end

      context 'when existing user' do
        before do
          create(
            :connect_google,
            identifier: '104056056838641922879',
            access_token: 'access_token'
          )
        end

        it 'should authenticate user without accessing userinfo endpoint' do
          post :create, params: {code: code}
          response.should redirect_to dashboard_path
        end
      end
    end

    context 'without code' do
      it do
        post :create
        flash[:warning].should == 'Google Login Failed'
        response.should redirect_to root_path
      end
    end
  end
end
