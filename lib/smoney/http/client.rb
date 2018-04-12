require 'net/http'

# Simple HTTP client, temporary. Best would be to rely on HTTParty.
module Smoney::Http

  # HTTP client class.
  #
  # Usage:
  #
  #     client = Smoney::Http::Client.new "http://www.some.api"
  #
  #     response = client.get
  #     hash = response.from_json
  #
  class Client

    include Net

    # Initialize with the target URL and some optional headers.
    def initialize(url = "http://localhost:3000", headers = {})
      @uri = URI url
      @headers = headers
    end

    # Generate an HTTP request with the supplied HTTP verb.
    #
    # Usage:
    #
    #     http :Get
    #
    def http(verb)
      request = HTTP::const_get(verb).new @uri
      @headers.each { |header, value| request[header] = value }
      request
    end

    # Perform an actual HTTP request. The connection object is
    # passed to the block.
    #
    # Usage:
    #
    #     response = start { |connection| connection.request http :Get }
    #
    def start(&block)
      ssl = @uri.scheme == 'https'
      HTTP.start(@uri.hostname, @uri.port, :use_ssl => ssl) do |connection|
        yield connection
      end
    end

    # Submit data to an HTTP server with the supplied HTTP verb.
    #
    # Usage:
    #
    #     submit :Post, "query=some_data"
    #
    def submit(verb, data)
      start do |connection|
        request = http verb
        request.body = data
        connection.request request
      end
    end

    # Perform a GET request.
    def get
      start { |connection| connection.request http :Get }
    end

    # Perform a POST request.
    def post(data = "")
      submit :Post, data
    end

    # Perform a PUT request.
    def put(data = "")
      submit :Put, data
    end

    # Perform a DELETE request.
    def delete
      start { |connection| connection.request http :Delete }
    end

    # Post a multipart form.
    # Expects an array of hash structures containing:
    # - :name
    # - :filename
    # - :content_type
    # - :content
    def multipart(files = [])
      boundary = "N0tS0R4nd0m"
      boundary_line = "--#{ boundary }\r\n"
      @headers['Content-Type'] = "multipart/form-data; boundary=#{ boundary }"
      body = files.map do |file|
        part_header = "Content-Disposition: form-data; name=\"#{ file[:name] }\"; filename=\"#{ file[:filename] }\"\r\n"
        part_header += "Content-Type: #{ file[:content_type] }\r\n\r\n"
        part = file[:content] + "\r\n"
        part_header + part
      end
      body = boundary_line + body.join(boundary_line) + boundary_line.rstrip + "--\r\n"
      @headers['Content-Length'] = body.size
      start do |connection|
        request = http :Post
        request.body = body
        connection.request request
      end
    end

    # Perform an HTTP GET request with a query string.
    def query
      start do |connection|
        request = HTTP::Get.new "#{ @uri.path }?#{ @uri.query }"
        @headers.each { |header, value| request[header] = value }
        connection.request request
      end
    end
  end
end
