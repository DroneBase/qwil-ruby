# https://staging.qwil.co/docs

require "faraday"
require "faraday_middleware"

# resources
require "qwil/api_error"
require "qwil/api_request"
require "qwil/api_resource"
require "qwil/api_response"
require "qwil/contractor"
require "qwil/income"

module Qwil
  class ArgumentError < StandardError; end

  # in dev and test enviroments you might have to set this to false (NEVER IN PRODUCTION!).
  # remote api might not like your lame local open ssl cert.
  @verify_ssl_certs = true

  class << self
    attr_accessor :api_email, :api_password, :verify_ssl_certs, :api_host
    attr_reader :api_platform_uri, :api_token

  end

  def self.request
    raise ArgumentError,
      "Requires: api_host" unless @api_host

    request_options = {}
    request_options[:url] = "https://#{@api_host}"
    unless @verify_ssl_certs
      request_options[:ssl] = {:verify_mode => OpenSSL::SSL::VERIFY_NONE}
    end
    if @api_token
      request_options[:headers] = {:Authorization => "Bearer #{@api_token}"}
    end

    @request ||= Faraday.new(request_options) do |faraday|
      faraday.request :json
      faraday.use APIRequest
      faraday.response :json, :content_type => /\bjson$/
      faraday.use APIResponse
      faraday.adapter Faraday.default_adapter
    end
  end

  def self.authenticate
    raise ArgumentError,
      "Requires: api_username, api_password" unless @api_password && @api_email

    res = request.post "/api-token-auth/", { :email => @api_email, :password => @api_password }

    if res.status == 200 && res.body['token'] && res.body['user']['platform_summary']['url']
      @api_platform_uri = res.body['user']['platform_summary']['url'].split('/')[3..-1].join('/')
      @request = nil # make sure next requests get a new object with correct token
      @api_token = res.body['token']
    else
      raise APIError,
        "Authentication failed to get token and platform_summary url: #{res.body}"
    end
  end

  def self.api_platform_uri
    unless @api_platform_uri
      authenticate
    end
    @api_platform_uri
  end

  def self.validate_token
    res = request.post '/api-token-verify/', { :token => @api_token }

    raise APIError,
      "Invalid Qwil Token: #{res}" unless res.status == 200
  end
end
