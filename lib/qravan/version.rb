# frozen_string_literal: true

module Qravan
  VERSION = "0.1.1"
  ENV = "development"

  class Spec

    def call(env)
      body = [Qravan::Spec.collect_spec.to_json]
      status  = 200
      headers = { "content-type" => "application/json" }

      [status, headers, body]
    end

    class << self
      def collect_spec
        {
          "spec": {
            "server": {
              "type": "Qravan Server",
              "version": Qravan::VERSION,
              "env": Qravan::ENV
            },
            "protocol": {
              "type": "Qravan Spec",
              "version": "1.0"
            }
          }
        }
      end
    end
  end
end
