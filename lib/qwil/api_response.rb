module PaymentProcessor
  module Qwil
    class APIResponse < Faraday::Middleware

      def initialize(app)
        super(app)
      end


      def call(environment)
        @app.call(environment).on_complete do |env|

          case env.status
          when 403
            if token = PaymentProcessor::Qwil.authenticate
              environment.request_headers['Authorization'] = "Bearer #{token}"
              call(environment)
            else
              raise APIError.new("Authentication failed in #{CGI.escape(self.class.to_s)}", environment.status, environment.body, environment.headers).to_s
            end
          end

        end
      end

    end
  end
end
