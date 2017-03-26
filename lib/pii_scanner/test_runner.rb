require "pii_scanner/config"

module PiiScanner
  class TestRunner
    def initialize(config)
      @config = config
    end

    def run(models)
      @config.test_cases.map do |test_case|
        failing_case = test_case.failing_case(models)
        failing_case if failing_case
      end.compact
    end
  end
end
