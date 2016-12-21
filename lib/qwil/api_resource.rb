module PaymentProcessor
  module Qwil
    class APIResource

      NON_PLURAL_RESOURCE_CLASSNAMES = ['income']

      def self.class_name
        self.name.split('::').last.downcase
      end

      def self.platform_resource_uri(id=nil)
        uri = "/#{Qwil.api_platform_uri}/"

        if NON_PLURAL_RESOURCE_CLASSNAMES.exclude? class_name
          uri = "#{uri}#{class_name}s/"
        else
          uri = "#{uri}#{class_name}/"
        end

        if id
          uri = "#{uri}#{id}/"
        end

        uri
      end

      def platform_resource_uri(id=nil)
        self.class.platform_resource_uri(id)
      end

      def self.request
        PaymentProcessor::Qwil.request
      end

      def request
        self.class.request
      end

      def api_host
        PaymentProcessor::Qwil.api_host
      end

    end
  end
end
