module Pass2u
  class Error < StandardError; end

  class ApiResponseError < Error
    attr_reader :original_error

    def initialize(message, original_error)
      super(message)
      @original_error = original_error
    end
  end

  class ApiConnectionError < Error
    attr_reader :original_error

    def initialize(message, original_error)
      super(message)
      @original_errror = original_error
    end
  end
end