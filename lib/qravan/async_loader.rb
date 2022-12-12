require "async"
require "async/barrier"
require "async/http/internet"

class AsyncLoader
  def self.perform(urls)
    internet = Async::HTTP::Internet.new
    barrier = Async::Barrier.new
    time = Time.now
    requests = 0
    result = []
    urls.each do |url|
      barrier.async do
        Console.logger.info "AsyncHttp#get: #{url}"
        begin
          response = internet.get(url)
          body = JSON.parse(response.read)
          result << { url: url, body: body }
          requests += 1
        ensure
          response.finish
        end
        Console.logger.info "AsyncHttp#fulfill: #{url}"
      end
    end

    Console.logger.info "AsyncHttp#wait"
    barrier.wait
    total = Time.now - time
    result.unshift({time: "Duration: #{Time.now - time}s for #{requests} (RPS: #{(requests / total).to_i} r/s)"})
    result.to_json
  end
end
