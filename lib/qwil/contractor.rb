module PaymentProcessor
  module Qwil
    class Contractor < APIResource

      attr_accessor :email, :first_name, :last_name
      attr_reader :id

      def initialize(args={})
        @email = args[:email]
        @first_name = args[:first_name]
        @last_name = args[:last_name]

        raise ArgumentError,
          "Contractor missing requried arguments: email, first_name, last_name" unless @email && @first_name && @last_name
      end

      def save
        res = request.post platform_resource_uri, self.as_json
        if res.status == 201
          @id = res.body['url'].split('/').last
        else
          raise APIError.new("Failed to create contractor.", res.status, res.body, res.headers).to_s
        end
      end

      def self.find(id)
        res = request.get platform_resource_uri(id)
        if res.status == 200
          res.body['id'] = res.body['url'].split('/').last
          account_res = request.get res.body['default_account']
          if account_res.status == 200
            res.body['default_account'] = account_res.body
          end
          res.body
        else
          raise APIError.new("Failed to find contractor.", res.status, res.body, res.headers).to_s
        end
      end

      def self.find_all
        res = request.get platform_resource_uri
        res.body.each {|contractor| contractor['id'] = contractor['url'].split('/').last }
        res.body
      end
    end
  end
end
