require 'webmock/rspec'

module MockGoogle
  def mock_google(method, endpoint, response_path, options = {})
    stub_request(method, endpoint).with(
      google_request_for(method, options)
    ).to_return(
      google_response_for(response_path, options)
    )
    if block_given?
      response = yield
      a_request(method, endpoint).with(
        google_request_for(method, options)
      ).should have_been_made.once
      response
    end
  end

  private

  def google_request_for(method, options = {})
    request = {}
    if options[:access_token]
      request[:headers] ||= {}
      request[:headers] = {
        authorization: "Bearer #{options[:access_token]}"
      }
    end
    params = options.try(:[], :params) || {}
    case method
    when :post, :put, :delete
      request[:body] = params
    else
      request[:query] = params
    end
    request
  end

  def google_response_for(response_path, options = {})
    response = {}
    response[:body] = google_response_file_for response_path
    if options[:status]
      response[:status] = options[:status]
    end
    response
  end

  def google_response_file_for(response_path)
    _response_file_path_ = if File.exist? response_path
      response_path
    else
      File.join(
        File.dirname(__FILE__), '../mock_json/google', "#{response_path}.json"
      )
    end
    unless File.exist? _response_file_path_
      google_response_file_required! _response_file_path_
    end
    File.new _response_file_path_, 'r', encoding: 'utf-8'
  end

  def google_response_file_required!(response_path)
    warn 'No response file found.'
  end
end

include MockGoogle
WebMock.disable_net_connect!