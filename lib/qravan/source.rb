# frozen_string_literal: true

require "yaml"

module Qravan
  # Sources for data extractions class
  class Source
    attr_accessor :sources

    def initialize(cargo = {})
      @sources ||= cargo.sources
    end

    def call(env)
      body = [unpassworded.to_json]
      status  = 200
      headers = { "content-type" => "application/json" }

      [status, headers, body]
    end

    def unpassworded
      sources.map { |key, value| sources[key]["password"] = "******" if sources[key]["password"] }
      sources
    end
  end
end
