# frozen_string_literal: true
module Qravan
  # Resource processing class
  class Resource
    attr_accessor :connections, :cargo

    def initialize(name, data, cargo = {})
      @resource = name
      @resource_data = data
      @cargo ||= cargo
      @connections = cargo.connections
    end

    def validate
      @resource_data
    end

    def extract
      source_name = "#{cargo.models[@resource]["extract"]["source"]["name"]}_source"
      @connections[source_name.to_s].extract(sql)
    end

    def sql
      [
        :select,
        @resource_data["attributes"].join(","),
        :from,
        cargo.models[@resource]["extract"]["source"]["table"],
        where
      ].flatten.join(" ")
    end

    def where
      if @resource_data["conditions"]
        [
          :where,
          @resource_data["conditions"].map { |k, v| "#{k}='#{v}'" }
                                      .join(" and ")
        ]
      else
        [""]
      end
    end
  end
end
