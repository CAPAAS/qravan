# frozen_string_literal: true
require_relative "query/request"
require_relative "query/response"
require_relative "resource/resource"
require_relative "source/db"
require_relative "source/rest"

module Qravan

  # Sources for data extractions class
  class Query

    def initialize(sources)
      Qravan::EXTRACTOR ||= sources
    end

    def call(env)
      query = Rack::Request.new(env)
      request = Qravan::Request.new(JSON.parse(query.body.read))
      response = Qravan::Response.new(request)

      body = [response.answer]
      status  = 200
      headers = { "content-type" => "application/json" }

      [status, headers, body]
    end
  end
end
