require_relative "../test_helper"
require_relative "../../lib/validators/data_validator"

module Validators
  class DataValidatorTest < MiniTest::Test

    def setup
      @validator = DataValidator.new
    end

    def test_should_always_succeed_without_validations
      assert @validator.validate(nil)
      assert_nil @validator.last_error
    end

    def test_satisfied_condition_should_result_in_successful_validation
      @validator.add("data must be 3") {|data| data == 3}
      assert @validator.validate(3), "should validate successfully"
    end

    def test_unsatisfied_condition_should_result_in_failed_validation
      @validator.add("data must be 3") {|data| data == 3}
      refute @validator.validate(4), "should fail validation"
    end

    def test_should_apply_all_validations
      @validator.add("data must be != 3") {|data| data != 3}
      @validator.add("data must be != 4") {|data| data != 4}

      assert @validator.validate(2), "should validate successfully"
      refute @validator.validate(3), "should fail validation"
      refute @validator.validate(4), "should fail validation"
    end

    def test_adding_validations_via_constructor_works_correctly
      validator = DataValidator.new([
        ["data must be != 2", ->(data) { data != 2 }],
        ["data must be != 3", ->(data) { data != 3 }]
      ])
      validator.add("data must be != 4") {|data| data != 4}

      refute validator.validate(2), "should fail validation"
      refute validator.validate(3), "should fail validation"
      refute validator.validate(4), "should fail validation"
      assert validator.validate(5), "should validate successfully"
    end

    def test_should_raise_when_adding_invalid_validation
      assert_raises ArgumentError do
        @validator.add("") {|data| data != 3}
      end

      assert_raises ArgumentError do
        @validator.add(nil) {|data| data != 3}
      end

      assert_raises ArgumentError do
        @validator.add("nil validation", nil)
      end
    end

    def test_last_error_returns_correct_validation_message
      @validator.add("data must be != 3") {|data| data != 3}
      @validator.add("data must be != 4") {|data| data != 4}

      @validator.validate(3)
      assert_equal "data must be != 3", @validator.last_error

      @validator.validate(4)
      assert_equal "data must be != 4", @validator.last_error
    end

    def test_last_error_is_nil_when_validation_successful
      @validator.add("data must be != 3") {|data| data != 3}
      @validator.validate(4)
      assert_nil @validator.last_error
    end

  end
end
