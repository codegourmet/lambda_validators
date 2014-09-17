require 'simplecov' # has to be at top, will execute ../.simplecov

require 'validators'

require 'minitest/autorun'
require 'minitest/reporters'

if ENV["RM_INFO"] || ENV["TEAMCITY_VERSION"]
  MiniTest::Reporters.use! MiniTest::Reporters::RubyMineReporter.new
else
  MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new
end
