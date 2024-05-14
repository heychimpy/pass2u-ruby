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
      uri = client_request_uri(model_id)
      req = pass_creation_request(uri, barcode_id, options)
      response = make_request(uri, req)

      parse_response(response)

    rescue Pass2U::ApiResponseError => ex
      raise ApiResponseError.new(
        "API responded with an error: #{ex.original_error.message}",
        ex
      )
    rescue => ex
      raise ApiConnectionError.new(
        "Failed to connect to the API: #{ex.message}",
        ex
      )
    end

    private

    # Build the URI for the API request
    def client_request_uri(model_id)
      URI.parse("#{@base_uri}/models/#{model_id}/passes")
    end

    # Build the HTTP request
    def pass_creation_request(uri, barcode_id, options)
      request = Net::HTTP::Post.new(uri.request_uri, headers)
      request.body = body_content(barcode_id, options).to_json
      request
    end

    # Make the HTTP request
    def make_request(uri, request)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'
      http.request(request)
    end

    # Parse the response and handle errors
    def parse_response(response)
      if response.code.to_i != 200
        error_message = parse_error_message(response)
        raise Pass2U::ApiResponseError.new(
          "Unexpected response status: #{response.code},"\
          " message: #{error_message}",
          response
        )
      end
      JSON.parse(response.body)
    end

    # Parse error message from the response
    def parse_error_message(response)
      begin
        JSON.parse(response.body)['errorMessage'] || response.body
      rescue JSON::ParserError
        response.body
      end
    end

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