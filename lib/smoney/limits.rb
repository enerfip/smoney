module Smoney
  class Limits
    class Limit
      attr_reader :annual_allowance, :used_allowance, :renewal_date
      def initialize(h)
        @annual_allowance = h['AnnualAllowance']
        @used_allowance = h['UsedAllowance'].to_i
        @renewal_date = DateTime.parse(h['RenewalDate']) if h['RenewalDate']
      end

      def percent_used
        return 0 if annual_allowance == 0
        used_allowance * 100 / annual_allowance
      end
    end

    attr_reader :global_in, :global_out

    def initialize(url = "")
      @url = url + "/limits"
    end

    def _headers
      Smoney::headers
    end

    def _url
      @url
    end

    def get
      client = Smoney::Http::Client.new _url, _headers
      from_data(client.get.from_json)
      self
    end

    def to_h
      @data
    end

    def from_data(data = {})
      @data = data
      @global_in = Limit.new(data.fetch('GlobalIn') { { "AnnualAllowance" => 0, "UsedAllowance" => 0, "RenewalDate" => nil } })
      @global_out = Limit.new(data.fetch('GlobalOut') { { "AnnualAllowance" => 0, "UsedAllowance" => 0, "RenewalDate" => nil } })
      self
    end
  end
end
