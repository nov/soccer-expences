require 'rails_helper'

RSpec.describe Connect::FacebooksController, type: :controller do
  let(:signed_request) do
    'SV7uGSNKxN3KEIOPfWoxHQzBOIOlXtcfSzngsJVqwFk.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImNvZGUiOiJBUUFtTFN0VUw5TGJJOGVFdFBBb2h5MmVOU3BfOERjX25uYUp0S2NsMW5QWFpLUkRnRHcwNnBIZ0NuNml6cXVTdkFCREZXRmdrVUhfeXhxY2Rub05rVEVCWk0zS1lzQWdURl9iWUU5UXZqN2hVcDVJTkdzV1JmZDJhdFVERWN2Zi00bHdUWWQxYUREUU1BMkEyYTFZYmtyQjY1ajN6d010SHlfbDMySDgzalBldExsRFlOMnpaV1lhVmpwWDBBaHpXaXhNRlNsM0ZXUXFSaTY4VXFTbkxHWjBmWjdKWUU4dkF6LXVYNXdHS1U4YzZQOVBiZ3Q0QWdqMVQtTXhmWnBpUlM4alh6TWJGcnhBS2xCcXdtR3dDbVR6SklYc3M5MzI2WGsySjl0M2c5c1FEd3BPdWZ1TmliLWlZZFBXdWRQeXFSWjFHT0JXclpYQ2plWE9iS0hFVnlkRiIsImlzc3VlZF9hdCI6MTQ1MDMzODM4MSwidXNlcl9pZCI6IjEwMTUzNzg4MjMwNTkyMjc3In0'
  end

  describe '#create' do
    context 'with signed_request cookie' do
      before do
        request.cookies["fbsr_#{Connect::Facebook.config[:client_id]}"] = signed_request
        mock_graph :post, 'oauth/access_token', 'access_token'
      end

      context 'with email scope' do
        before do
          mock_graph :get, 'me', 'me', params: {fields: 'name,email'}
        end

        it do
          post :create
          response.should redirect_to dashboard_path
        end
      end

      context 'without email scope' do
        before do
          mock_graph :get, 'me', 'me_without_email', params: {fields: 'name,email'}
        end

        it do
          post :create
          flash[:warning].should == 'FB Permission Missing'
          response.should redirect_to root_path
        end
      end
    end

    context 'without signed_request cookie' do
      it do
        post :create
        flash[:warning].should == 'FB Login Failed'
        response.should redirect_to root_path
      end
    end
  end
end
