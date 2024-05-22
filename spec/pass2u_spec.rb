require 'spec_helper'
require 'pass2u'

RSpec.describe Pass2u do
  describe '.configuration' do
    it 'returns a Configuration object' do
      expect(Pass2u.configuration)
        .to be_an_instance_of(Pass2u::Configuration)
    end

    it 'memoizes the configuration object' do
      config1 = Pass2u.configuration
      config2 = Pass2u.configuration

      expect(config1).to be(config2)
    end
  end

  describe '.configure' do
    it 'yields the configuration object' do
      expect { |b| Pass2u.configure(&b) }
        .to yield_with_args(Pass2u.configuration)
    end

    it 'allows setting configuration options' do
      Pass2u.configure do |config|
        config.api_key = 'api_key'
      end

      expect(Pass2u.configuration.api_key).to eq('api_key')
    end
  end
end
