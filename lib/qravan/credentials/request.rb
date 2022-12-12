# frozen_string_literal: true

module Qravan
  module Credentials
    # Request credentials
    class Request
      attr_accessor :credentials

      def initialize(credentials)
        @credentials = credentials["request"]
      end

      def prepare
        {
          id: id,
          sub_id: sub_id,
          name: name,
          purpose_id: purpose,
          audit: audit,
          audit_id: audit_id,
          audit_token: audit_token
        }
      end

      def id
        @credentials["id"]
      end

      def sub_id
        @credentials["sub_id"]
      end

      def name
        @credentials["name"]
      end

      def purpose
        @credentials["purpose_id"]
      end

      def audit
        @credentials["audit"]
      end

      def audit_id
        @credentials["audit_id"]
      end

      def audit_token
        @credentials["audit_token"]
      end
    end
  end
end
