module PaymentProcessor
  module Qwil
    class Income < APIResource

      attr_accessor :id, :amount, :user_id
      attr_reader :user

      def initialize(user_id, amount, notes='')

        raise ArgumentError,
          "amount and user_id are required arguments." unless amount && user_id

        #  Qwil expects a :user param with resource url instead of id.
        @amount = amount
        @user = "https://#{api_host}/users/#{user_id}/"
        @notes = notes
        # @income.delete(:user_id)
      end

      def save
        res = request.post platform_resource_uri, self.as_json
        if res.status == 201
          @id = res.body['url'].split('/').last
        else
          raise APIError.new("Failed to create income.", res.status, res.body, res.headers).to_s
        end
      end

      def self.retrieve(id)
        res = request.get platform_resource_uri(id)
        if res.status == 200
          res.body
        else
          raise APIError.new("Failed to find income.", res.status, res.body, res.headers).to_s
        end
      end

      def self.retrieve_all
        res = request.get platform_resource_uri
        if res.status == 200
          res.body
        else
          raise APIError.new("Failed to find incomes.", res.status, res.body, res.headers).to_s
        end
      end
    end
  end
end
