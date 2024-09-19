# pass2u-ruby
![Github Chimpy](https://github.com/user-attachments/assets/df1179f1-aa19-415e-aad8-e5037d060519)

[![Continuous Integration](https://github.com/heychimpy/pass2u-ruby/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/heychimpy/pass2u-ruby/actions/workflows/test.yml)
[![codecov](https://codecov.io/gh/heychimpy/pass2u-ruby/graph/badge.svg?token=b6e1b9ae-6853-4f98-a65e-ca97fd9119b8)](https://codecov.io/gh/heychimpy/pass2u-ruby)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
![Reek Badge](https://img.shields.io/badge/code%20quality-reek-brightgreen?style=flat-square)
![Brakeman Badge](https://img.shields.io/badge/security-brakeman-brightgreen?style=flat-square)

A Ruby interface for the Pass2u API, allowing the management of digital passes.

- [Installation](#installation)
- [Usage](#usage)
  - [Configuration](#configuration)
  - [Basic usage](#basic-usage)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pass2u-ruby'
```

Then run:

```ruby
bundle
```

## Usage

### Configuration

Before using the gem, configure it with your API key and the base uri:

```ruby
Pass2u.configure do |config|
  # The API key provided by Pass2u
  config.api_key = 'your_pass2u_api_key_here'
  # The base URI for all API calls
  config.base_uri = 'https://api.pass2u.net/v2'  # default value
end
```

### Basic usage

Creating a Client

```ruby
client = Pass2u::Client.new
```

Creating a Pass

Use the create_pass method to create a new pass. You need to provide the model ID and barcode ID, along with any optional parameters.

Refer to the Pass2u [docs](https://www.pass2u.net/documentation) for a complete list of optional parameters.

```ruby
model_id = 'your_model_id_here'
barcode_id = 'your_barcode_id_here'
options = { 'option_key' => 'option_value' } 

response = client.create_pass(model_id, barcode_id, options)

# optional parameters override parameters specified in the model
```

Response example

```ruby
{
  "barcodeMessage":"1234567890",
  "modelId":1919,
  "passId":"VT-2I77F5ADz",
  "createdTime":"2018-01-25T16:19:36+08:00",
  "expirationDate":"2018-12-31T23:00:15+08:00"
}
```
