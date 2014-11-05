lambda_validators
=================

Simple all-purpose data validation (lambda-based).

*NOTE* If you're validating hashes, I suggest you have a look at https://github.com/jamesbrooks/hash_validator
I haven't tested it out yet, but it looks nice.


Until complete documentation is done, here are some examples, taken from the unit tests:

(1) Adding validations one-by-one in block syntax:

    validator = DataValidator.new
    validator.add("data must be != 3") {|data| data != 3}
    validator.add("data must be != 4") {|data| data != 4}

    validator.validate(2) # => true
    validator.last_error # => nil

    validator.validate(3) # => false
    validator.last_error # => "data must be != 3"

(2) Adding multiple validations as lambdas via constructor as Array:

    validator = DataValidator.new([
      ["data must be != 2", ->(data) { data != 2 }],
      ["data must be != 3", ->(data) { data != 3 }]
    ])

(3) You can of course mix both versions.

