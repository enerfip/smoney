require 'json'
require 'net/http'

class Net::HTTPResponse

  def from_json
    JSON.parse body
  end
end
