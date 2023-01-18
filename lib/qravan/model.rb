# frozen_string_literal: true

module Qravan
  # Models for data extractions class
  class Model
    attr_accessor :models

    def initialize(cargo = {})
      @models ||= cargo.models
    end

    def call(env)
      body = [models.to_json]
      status  = 200
      headers = { "content-type" => "application/json" }

      [status, headers, body]
    end
  end
end
