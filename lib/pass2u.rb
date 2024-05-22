require 'pass2u/client'
require 'pass2u/configuration'

module Pass2u
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end

