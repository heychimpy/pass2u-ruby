require 'spec_helper'
require 'pass2u'
require 'net/http'

RSpec.describe Pass2U::Client do

  let(:api_key) { '123456789' }
  let(:base_uri) { 'https://api.pass2u.net/v2' }
  let(:model_id) { '123' }
  let(:barcode_id) { '456' }

  let(:response_body) { { 'passId' => '789' }.to_json }
  let(:response_code) { 200 }
  let(:parsed_response) { JSON.parse(response_body) }

  let(:http) { instance_double(Net::HTTP) }
  let(:client) { described_class.new }

  before do
    Pass2U.configure do |config|
      config.api_key = api_key
      config.base_uri = base_uri
    end
  end

  describe '#create_pass' do

    before do
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
    end

    context 'Succeesful request' do

      let(:response_code) {  200 }

      before do
        response = instance_double(
          Net::HTTPResponse,
          body: response_body,
          code: response_code
        )

        allow(http).to receive(:use_ssl=)
        .with(true)

        allow(http).to receive(:request)
          .with(instance_of(Net::HTTP::Post))
          .and_return(response)
      end

      it 'sends a POST request to create a pass' do

        result = client.create_pass(
          model_id,
          barcode_id,
          { 'expirationDate' => '2024-12-31T23:00:15+02:00' }
        )

        expect(result).to eq(parsed_response)
      end
    end

    context 'Failed request' do

      context 'API response error' do

        let(:response_code) {  400 }
        let(:response_body) { { 'errorMessage' => 'Bad Request' }.to_json }

        before do
          response = instance_double(
            Net::HTTPResponse,
            body: response_body,
            code: response_code,
            message: 'original error message'

          )

          allow(http).to receive(:use_ssl=)
            .with(true)

          allow(http).to receive(:request)
            .with(instance_of(Net::HTTP::Post))
            .and_return(response)
        end

        it 'raises a custom API response error' do
          expect {
            client.create_pass(
              model_id, barcode_id,
              'expirationDate' => '2024-12-31T23:00:15+02:00'
            )
          }.to raise_error(
            Pass2U::ApiResponseError,
            "API responded with an error: original error message"
          )
        end
      end

      context 'API connection error' do

        before do
          response = instance_double(
            Net::HTTPResponse,
            body: response_body,
            code: response_code
          )

          allow(http).to receive(:use_ssl=).and_raise
        end

        it 'raises a custom API connection error' do
          expect {
            client.create_pass(
              model_id, barcode_id,
              'expirationDate' => '2024-12-31T23:00:15+02:00'
            )
          }.to raise_error(Pass2U::ApiConnectionError)
        end
      end
    end
  end
end
