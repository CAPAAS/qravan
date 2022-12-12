# frozen_string_literal: true

module Qravan
  class Response
    attr_accessor :request
    attr_accessor :resources
    attr_accessor :credentials

    def initialize(request)
      @request ||= request
      @resources = request.resources
      @credentials = request.credentials
    end

    def validate
      @request
    end

    def answer
      {
        "response": @resources,
        "credentials": Qravan::Credentials::Query.new(@credentials).credentials
      }.to_json
    end
  end
end
