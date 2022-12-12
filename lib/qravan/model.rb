# frozen_string_literal: true

module Qravan
  # Sources for data extractions class
  class Model

    def call(env)
      body = [Qravan::Model.list]
      status  = 200
      headers = { "content-type" => "application/json" }

      [status, headers, body]
    end

    class << self
      def list
        {}.to_json
      end
    end
  end
end
