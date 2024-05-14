require 'json'
require 'net/http'

module Pass2U
  class Client

    def initialize
      @base_uri = Pass2U.configuration.base_uri
      @api_key = Pass2U.configuration.api_key
    end

    # Create a pass for a given model id and barcode id
    #
    # @param model_id [String] ID of the model used for the pass
    # @param barcode_id [String] ID of the barcode used for the pass
    # @param options [Hash] Optional parameters to override model defaults
    # @return [Hash] Response from the Pass2u API
    def create_pass(model_id, barcode_id, options = {})
      uri = URI.parse("#{@base_uri}/models/#{model_id}/passes")

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'

      request = Net::HTTP::Post.new(uri.request_uri, headers)
      request.body = body_content(barcode_id, options).to_json

      resp = http.request(request)

      JSON.parse(resp.body)
    end

    private

    # Prepare the content of the request body
    def body_content(barcode_id, options = {})
      { 'barcode' => {
        'message' => barcode_id,
        'altText' => barcode_id
      }}.merge(options)
    end

    # Set the headers of the HTTP requests
    def headers
      {
        'x-api-key' => @api_key,
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }
    end
  end
end