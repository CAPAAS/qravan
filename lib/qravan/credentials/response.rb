# frozen_string_literal: true

module Qravan
  module Credentials
    # Response credentials
    class Response
      attr_accessor :credentials

      def initialize(response_credentials = {})
        @credentials = response_credentials
      end

      def prepare
        {
          id: id,
          sub_id: sub_id,
          started_at: started_at,
          finished_at: finished_at
        }
      end

      def id
        @credentials["id"]
      end

      def sub_id
        @credentials["sub_id"]
      end

      def started_at
        @credentials["started_at"]
      end

      def finished_at
        @credentials["finished_at"]
      end
    end
  end
end
