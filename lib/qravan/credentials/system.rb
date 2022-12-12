# frozen_string_literal: true
module Qravan
  module Credentials
    # System credentials
    class System
      attr_accessor :credentials

      def initialize(credentials)
        @credentials = credentials["system"]
      end

      def prepare
        {
          mnemonic: mnemonic,
          instance_id: instance,
          user_id: user
        }
      end

      def mnemonic
        @credentials["mnemonic"]
      end

      def instance
        @credentials["instance_id"]
      end

      def user
        @credentials["user_id"]
      end
    end
  end
end
