module Pass2u
  class Configuration

    attr_accessor :api_key, :base_uri

    def initialize
      set_defaults
    end

    private

    def set_defaults
      @api_key = ''
      @base_uri = 'https://api.pass2u.net/v2'
    end
  end
end