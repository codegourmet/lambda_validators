module LambdaValidators

  # TODO README
  # TODO RDOC
  #
  # NOTE (todo move into doc) validator validates only once, since
  #   some validations might be based upon others being successful
  #   example:
  #     data["key_1"].present?
  #     data["key_1"]["key_2].present?
  #
  #   if the validator doesn't abort after the first validation, the
  #   non-existent key "key_1" would throw a NoMethodError later
  #
  class DataValidator
    attr_accessor :last_error

    def initialize(validations = {})
      @validations = []
      @last_error = nil
      validations.each {|message, validator| add(message, &validator)}
    end

    def add(message, &validator)
      raise ArgumentError.new("message must be present") if message.nil? || message.empty?
      raise ArgumentError.new("validation must be present") if validator.nil?
      @validations << [message, validator]
    end

    def validate(data)
      @last_error = nil

      @validations.each do |validation|
        message, validator = validation

        if !validator.call(data)
          @last_error = message
          break
        end
      end

      @last_error.nil?
    end
  end

end
