require 'spec_helper'
require 'pass2u'

RSpec.describe Pass2U do
  describe '.configuration' do
    it 'returns a Configuration object' do
      expect(Pass2U.configuration)
        .to be_an_instance_of(Pass2U::Configuration)
    end

    it 'memoizes the configuration object' do
      config1 = Pass2U.configuration
      config2 = Pass2U.configuration

      expect(config1).to be(config2)
    end
  end

  describe '.configure' do
    it 'yields the configuration object' do
      expect { |b| Pass2U.configure(&b) }
        .to yield_with_args(Pass2U.configuration)
    end

    it 'allows setting configuration options' do
      Pass2U.configure do |config|
        config.api_key = 'api_key'
      end

      expect(Pass2U.configuration.api_key).to eq('api_key')
    end
  end
end
