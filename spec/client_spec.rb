require 'spec_helper'
require 'pass2u'
require 'net/http'

RSpec.describe Pass2U::Client do

  let(:api_key) { '123456789' }
  let(:base_uri) { 'https://api.pass2u.net/v2' }
  let(:model_id) { '123' }
  let(:barcode_id) { '456' }

  let(:response_body) { { 'passId' => '789' }.to_json }
  let(:parsed_response) { JSON.parse(response_body) }
  let(:response) { instance_double(Net::HTTPResponse, body: response_body) }

  let(:http) { instance_double(Net::HTTP) }
  let(:client) { described_class.new }

  before do
    Pass2U.configure do |config|
      config.api_key = api_key
      config.base_uri = base_uri
    end
  end

  describe '#create_pass' do
    it 'sends a POST request to create a pass' do
      expected_body = { 
        'barcode' => { 
          'message' => barcode_id, 
          'altText' => barcode_id 
        } 
      }

      uri = URI.parse("#{base_uri}/models/#{model_id}/passes")
      headers = {
        'x-api-key' => api_key,
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }

      request = Net::HTTP::Post.new(uri.request_uri, headers)
      request.body = expected_body.merge(
        'expirationDate' => '2024-12-31T23:00:15+02:00')
        .to_json

      allow(Net::HTTP).to receive(:new)
        .with(uri.host, uri.port)
        .and_return(http)

      allow(http).to receive(:use_ssl=)
        .with(true)

      allow(http).to receive(:request)
        .with(instance_of(Net::HTTP::Post))
        .and_return(response)

      result = client.create_pass(
        model_id, 
        barcode_id, 
        { 'expirationDate' => '2024-12-31T23:00:15+02:00' }
      )

      expect(result).to eq(parsed_response)
    end
  end
end
