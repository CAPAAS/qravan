# frozen_string_literal: true

module Qravan
  module Credentials
    # System credentials
    class Signature
      attr_accessor :credentials

      def initialize(credentials)
        @credentials = credentials["signature"]
      end

      def prepare
        {
          digest: digest,
          signature: signature
        }
      end

      def digest
        @credentials["digest"]
      end

      def signature
        @credentials["signature"]
      end

    end
  end
end
