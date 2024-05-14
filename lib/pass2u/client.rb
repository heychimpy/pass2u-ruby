require 'json'
require 'httparty'


module Pass2U
  class Client

    include HTTParty

    def initialize
      self.class.base_uri Pass2U.configuration.base_uri
      @api_key = Pass2U.configuration.api_key
    end

    # Create a pass for a given model id and barcode id
    #
    # @param model_id [String] ID of the model used for the pass
    # @param barcode_id [String] the id of the barcode used for the pass
    # @param options [Hash] Optional parameters to override model defaults
    # @return [Hash] the response from the Pass2u API
    def create_pass(model_id, barcode_id, options = {})
      self.class.post(
        "/models/#{model_id}/passes", {
          :headers => headers,
          :body => body_content(barcode_id, options).to_json
        }
      )
    end

    private

    # Prepare the content of the request body
    def body_content(barcode_id, options = {})
      { 'barcode' => {
        'message' => barcode_id,
        'altText' => barcode_id
      }}.merge(options)
    end

    # Prepare the headers of the HTTP requests
    def headers
      {
        'x-api-key' => @api_key,
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }
    end
  end
end