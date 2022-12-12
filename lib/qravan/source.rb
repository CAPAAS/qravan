# frozen_string_literal: true
require "yaml"

module Qravan
  # Sources for data extractions class
  class Source
    attr_accessor :sources

    def call(env)
      body = [@sources.to_json]
      status  = 200
      headers = { "content-type" => "application/json" }

      [status, headers, body]
    end

    def initialize
      @sources ||= Qravan::SOURCES.sources
    end

    def extract(source_name = "base", sql = "select 1;")
      source = @sources["#{source_name}_source"]
      if source["type"] == "rest"
        Qravan::Rest.new(source).extract(sql)
      else
        Qravan::Db.new(source).extract(sql)
      end
    end

  end
end
