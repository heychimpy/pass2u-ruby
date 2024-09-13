# pass2u-ruby
![chimpy logo](https://github.com/user-attachments/assets/4fdef0b2-69d7-444e-85e3-4deb12a8a02a)


[![Continuous Integration](https://github.com/heychimpy/pass2u-ruby/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/heychimpy/pass2u-ruby/actions/workflows/test.yml)


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
