# frozen_string_literal: true

module Qravan
  # Load models and sources to cargo
  class Cargo
    attr_accessor :sources, :models, :connections

    def initialize
      Console.logger.info "Cargo initialized:"
      Console.logger.info "Sources: #{sources.count}"
      Console.logger.info "Models: #{models.count}"
      Console.logger.info "Connections: #{connections.count}"
    end

    def sources
      @sources ||= preload_sources
    end

    def models
      @models ||= preload_models
    end

    def connections
      @connections ||= connect_sources
    end

    def preload_sources
      @sources = {}
      list("sources").each do |source|
        Console.logger.info "Reading source #{source}"
        preloaded_source = YAML.load_file("#{source}/1.0/source.yaml")
        @sources[preloaded_source.keys.first] = preloaded_source.first.last
      end
      @sources
    end

    def concat_models
      model_files = {}
      (list("models") - %w[models/current models/base]).each do |model|
        Console.logger.info "Reading model file #{model}/1.0/model.yaml"
        model_files[model] = File.readlines("#{model}/1.0/model.yaml").map(&:chomp)
      end

      File.open("models/current/model.yaml", "w") do |output_file|
        output_file.puts File.readlines("models/base/1.0/model.yaml").map(&:chomp)
        model_files.each { |elem| output_file.puts elem[1] }
      end
    end

    def preload_models
      concat_models
      @models = {}
      Console.logger.info "Preparing models"
      preloaded_models = YAML.load_file("models/current/model.yaml")
      preloaded_models["resources"].each do |model|
        @models[model.keys.first] = model
      end
      @models
    end

    def connect_sources
      @connections = {}
      sources.each do |source|
        case source[1]["type"]
        when "rest"
          @connections[source[0]] = Qravan::Rest.new(source[1])
        when "db"
          @connections[source[0]] = Qravan::Db.new(source[1])
        else
          Console.logger.warn "Not supported resource"
        end
      end
      @connections
    end

    def list(what = "sources")
      Dir["#{what}/*"]
    end
  end
end
