require 'net/http'
require 'json'

class MediumPoster
  attr_reader :api_key

  def initialize(api_key:)
    @api_key = api_key
    @author_id = getAuthorId
  end

  def post(body:)
    Net::HTTP.post URI("https://api.medium.com/v1/users/#{@author_id}/posts"),
                   body.to_json,
                   {"Content-Type": "application/json",
                    "Authorization": "Bearer #{@api_key}"}
  end

  private

  def getAuthorId
    resp = Net::HTTP.get URI("https://api.medium.com/v1/me"),
                  {"Content-Type": "application/json",
                   "Authorization": "Bearer #{@api_key}"}
    JSON.parse(resp, {symbolize_names: true})[:data][:id]
  end
end
