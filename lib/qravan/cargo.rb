# frozen_string_literal: true

module Qravan
  # Load models and sources to cargo
  class Cargo
    attr_accessor :sources, :models

    def initialize
      Console.logger.info 'Cargo initialized!'
    end

    def sources
      @sources ||= preload
    end

    def models
      @models ||= {}
    end

    def preload
      @sources = {}
      list.each do |source|
        Console.logger.info "Reading source #{source}"
        preloaded_source = YAML.load_file("#{source}/1.0/source.yaml")
        @sources[preloaded_source.keys.first] = preloaded_source.first.last
      end
      @sources
    end

    def list
      Dir["sources/*"]
    end
  end
end
