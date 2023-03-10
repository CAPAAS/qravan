# frozen_string_literal: true
require "async"
require "async/barrier"

module Qravan
  # Requests processing class
  class Request
    attr_accessor :resources, :sources, :cargo

    def initialize(request, cargo = {})
      @query = request["query"]
      @credentials = request["credentials"]
      @resources = []
      @cargo ||= cargo

      validate
      extract_resources
    end

    def validate
      @query
    end

    def extract_resources
      barrier = Async::Barrier.new
      barrier.async do
        @query.each do |key, resource|
          @resources << { key => Qravan::Resource.new(key, resource, cargo).extract }
        end
      ensure
        @resources
      end
      barrier.wait
    end

    def credentials
      @credentials
    end
  end
end
