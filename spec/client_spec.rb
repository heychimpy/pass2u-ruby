# spec/pass2u/client_spec.rb
require 'spec_helper'

describe Pass2U::Client do

  let(:api_key) { '123456789' }
  let(:client) { Pass2U::Client.new } 

  describe "#create_pass" do

    let(:model_id) { '123' }
    let(:barcode_id) { '456' }

    let(:options) do 
      { expirationDate: '2024-12-31T23:00:15+02:00' } 
    end

    let(:expected_body) do
      {
        barcode: {
          message: barcode_id,
          altText: barcode_id
        },
        expirationDate: '2024-12-31T23:00:15+02:00'
      }.to_json
    end
    
    let(:response) do 
      double(
        "response", 
        body: { 'passId' => '789' }.to_json, 
        success?: true
      ) 
    end

    before do
      allow(Pass2U).to receive(:configuration).and_return(
        double(
          "configuration", 
          base_uri: 'https://api.pass2u.net/v2', 
          api_key: api_key
        )
      )   
    end

    it "sends a POST request to create a pass" do
      expect(client.class).to receive(:post).with(
        "/models/#{model_id}/passes",
        hash_including(
        headers: {
          'x-api-key' => api_key,
          'Accept' => 'application/json',
          'Content-Type' => 'application/json'
        },
        body: expected_body)
      ).and_return(response)

      client.create_pass(model_id, barcode_id, options)
    end

    it 'returns the response' do
      allow(client.class).to receive(:post).and_return(response)
      result = client.create_pass(model_id, barcode_id, options)

      expect(result.body).to eq(response.body)
    end
  end
end
