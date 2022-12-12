#!/usr/bin/env -S falcon host
# frozen_string_literal: true

load :rack, :lets_encrypt_tls, :supervisor

hostname = File.basename(__dir__)
rack hostname, :lets_encrypt_tls do
  cache true
  endpoint Async::HTTP::Endpoint.parse("http://localhost:3300").with(protocol: Async::HTTP::Protocol::HTTP1)
end

supervisor
