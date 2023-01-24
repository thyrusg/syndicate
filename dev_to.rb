require 'net/http'
require 'json'


class DevToPoster
  DEV_TO_API_URL = URI("https://dev.to/api/articles")
  attr_reader :api_key

  def initialize(api_key:)
    @api_key = api_key
  end

  def post(body)
    Net::HTTP.post DEV_TO_API_URL,
                   body.to_json,
                   {"Content-Type" => "application/json",
                    "accept" => "application/vnd.forem.api-v1+json",
                    "published" => true,
                    "canonical_url" => "",
                    "api-key" => @api_key}
  end
end
