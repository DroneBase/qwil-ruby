require 'pry'
require 'Qwil'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.mock_with :mocha

  config.before(:each) do
    stub_request(:get, /staging.qwil.co/).
      with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Faraday v0.10.0'}).
      to_return(status: 200, body: "stubbed response", headers: {})
  end
  config.before(:each) do
    stub_request(:post, /staging.qwil.co/).
      with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Faraday v0.10.0'}).
      to_return(status: 201, body: "stubbed response", headers: {})
  end
end
