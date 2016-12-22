module Qwil
  class APIRequest < Faraday::Middleware

    def initialize(app)
      super(app)
    end

    def call(environment)
      if Qwil.api_token && !environment.request_headers['Authorization']
        environment.request_headers['Authorization'] = "Bearer #{Qwil.api_token}"
      end
      @app.call(environment)
    end
  end
end
