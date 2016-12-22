module Qwil
  class APIError < StandardError
    attr_reader :message
    attr_reader :http_status
    attr_reader :http_headers
    attr_reader :json_body

    def initialize(message=nil, http_status=nil, json_body=nil, http_headers=nil)
      @message = message
      @http_status = http_status
      @http_headers = http_headers || {}
      @json_body = json_body
    end

    def to_s
      status_string = @http_status.nil? ? "" : "(Status #{@http_status}) "
      error_message = @json_body.nil? ? "" : " response: #{json_body}"
      "#{status_string}##{@message}#{error_message}"
    end
  end
end
