require 'rails_helper'

RSpec.describe Connect::Facebook, type: :model do
  let(:cookie) do
    {
      "fbsr_#{Connect::Facebook.config[:client_id]}" => 'SV7uGSNKxN3KEIOPfWoxHQzBOIOlXtcfSzngsJVqwFk.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImNvZGUiOiJBUUFtTFN0VUw5TGJJOGVFdFBBb2h5MmVOU3BfOERjX25uYUp0S2NsMW5QWFpLUkRnRHcwNnBIZ0NuNml6cXVTdkFCREZXRmdrVUhfeXhxY2Rub05rVEVCWk0zS1lzQWdURl9iWUU5UXZqN2hVcDVJTkdzV1JmZDJhdFVERWN2Zi00bHdUWWQxYUREUU1BMkEyYTFZYmtyQjY1ajN6d010SHlfbDMySDgzalBldExsRFlOMnpaV1lhVmpwWDBBaHpXaXhNRlNsM0ZXUXFSaTY4VXFTbkxHWjBmWjdKWUU4dkF6LXVYNXdHS1U4YzZQOVBiZ3Q0QWdqMVQtTXhmWnBpUlM4alh6TWJGcnhBS2xCcXdtR3dDbVR6SklYc3M5MzI2WGsySjl0M2c5c1FEd3BPdWZ1TmliLWlZZFBXdWRQeXFSWjFHT0JXclpYQ2plWE9iS0hFVnlkRiIsImlzc3VlZF9hdCI6MTQ1MDMzODM4MSwidXNlcl9pZCI6IjEwMTUzNzg4MjMwNTkyMjc3In0'
    }
  end

  before do
    mock_graph :post, 'oauth/access_token', 'access_token'
  end

  describe '.authenticate' do
    context 'when email given' do
      it 'should success' do
        account = mock_graph :get, 'me', 'me', params: {
          fields: 'name,email'
        } do
          Connect::Facebook.authenticate cookie
        end
        account.should be_instance_of Account
        account.should be_persisted
        account.facebook.should be_persisted
      end
    end

    context 'otherwise' do
      it 'should fail' do
        mock_graph :get, 'me', 'me_without_email', params: {
          fields: 'name,email'
        } do
          expect do
            Connect::Facebook.authenticate cookie
          end.to raise_error ActiveRecord::RecordInvalid
        end
      end
    end
  end
end
