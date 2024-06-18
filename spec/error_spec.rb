require 'spec_helper'
require 'pass2u'

RSpec.describe Pass2u::ApiResponseError do
  let(:original_error) { ZeroDivisionError.new }
  let(:response_error) { described_class.new("error", original_error) }

  it 'stores the initial error' do
    expect(response_error.original_error).to eq(original_error)
  end
end

RSpec.describe Pass2u::ApiConnectionError do
  let(:original_error) { ZeroDivisionError.new }
  let(:connection_error) { described_class.new("error", original_error) }

  it 'stores the initial error' do
    expect(connection_error.original_error).to eq(original_error)
  end
end
