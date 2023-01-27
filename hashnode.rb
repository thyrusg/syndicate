require 'net/http'
require 'json'

class HashNodePoster
  HASHNODE_API_URL = URI("https://api.hashnode.com")
  def initialize(api_key:, username:)
    @api_key = api_key
    @username = username
    @publicationId = getPublicationId
  end

  def post(body:)
  end

  private

  def getPublicationId
    headers = {"Content-Type"=>"application/json", "Authorization"=>"#{@api_key}"}
    body = {
	"operationName": "getUserInfo",
	"query": "query getUserInfo {\n  user(username: \"#{@username}\") {\n    name\n    publication {\n      _id\n      author\n      meta\n      title\n    }\n    publicationDomain\n  }\n}"
    }.to_json
    resp = Net::HTTP.post HASHNODE_API_URL, body, headers
    @publicationId = JSON.parse(resp.body).dig("data", "user", "publication", "_id")
  end
end
