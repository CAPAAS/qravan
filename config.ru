# frozen_string_literal: true

# This file is used by Rack-based servers to start the application.
# use Rack::Deflater

require 'bundler/setup'
require 'qravan'

Console.logger.info Qravan::BANNER
Qravan::SOURCES = Qravan::Cargo.new

qravan = Rack::Builder.new do

  # use Rack::ShowExceptions
  use Rack::Logger

  map "/data" do
    use Rack::Lint
    run Qravan::Query.freeze.new(Qravan::SOURCES)
  end

  map "/model" do
    use Rack::Lint
    run Qravan::Model.new
  end

  map "/spec" do
    use Rack::Lint
    run Qravan::Spec.new
  end

  map "/sources" do
    use Rack::Lint
    run Qravan::Source.freeze.new
  end

  map "/ping" do
    use Rack::Lint
    run do |env|
      [200, {}, ["PONG!"]]
    end
  end

end

run qravan
