# frozen_string_literal: true
module Qravan
  # Resource processing class
  class Resource
    attr_accessor :sources

    def initialize(name, data, sources = {})
      @resource = name
      @resource_data = data
    end

    def validate
      @resource_data
    end

    def extract
      @resource = "smevql1.driverlicenseql3" if @resource_data["source"] == 'prostore'
      Qravan::Source.new.extract(@resource_data["source"], sql)
    end

    def sql
      [
        :select,
        @resource_data["attributes"].join(","),
        :from,
        @resource,
        :where,
        @resource_data["conditions"].map { |k, v| "#{k}='#{v}'" }
                                    .join(" and ")
      ].join(" ")
    end
  end
end
