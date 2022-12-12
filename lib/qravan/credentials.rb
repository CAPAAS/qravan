require_relative "credentials/system"
require_relative "credentials/request"
require_relative "credentials/response"
require_relative "credentials/signature"

module Qravan
  BANNER = %(
        Data API Qravan Server
        Developed at CAPAA by Alexander Panasenkov, 2022
).freeze
  module Credentials
    class Query
      attr_accessor :query_credentials

      def initialize(query_credentials)
        @query_credentials ||= query_credentials
      end

      def credentials
        {
          response: Qravan::Credentials::Response.new(@query_credentials).prepare,
          system: Qravan::Credentials::System.new(@query_credentials).prepare,
          request: Qravan::Credentials::Request.new(@query_credentials).prepare,
          signature: Qravan::Credentials::Signature.new(@query_credentials).prepare
        }
      end
    end
  end
end
