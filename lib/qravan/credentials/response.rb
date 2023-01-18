# frozen_string_literal: true

require "securerandom"

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
        SecureRandom.uuid
      end

      def sub_id
        SecureRandom.uuid
      end

      def started_at
        Time.now
      end

      def finished_at
        Time.now
      end
    end
  end
end
