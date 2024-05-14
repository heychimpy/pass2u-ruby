require 'pass2u/client'
require 'pass2u/configuration'

module Pass2U
  class << self
    
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end