require "pii_scanner/config"
require "pii_scanner/test_runner"
require "terminal-table"

module PiiScanner
  class Scan
    attr_reader :config, :errors

    extend Forwardable

    def_delegator :config, :scope_results

    def initialize(*config)
      @config = PiiScanner::Config.new(*config)
    end

    def scan!
      @errors = []
      test_runner = TestRunner.new(config)
      scope_results.each do |models|
        errors = test_runner.run(models)
        @errors += errors if errors.length > 0
      end
    end

    def failed?
      errors.length > 0
    end

    def report
      headings = ["Class name", "Pass" , "Reason"]
      Terminal::Table.new(rows: errors, headings: headings)
    end
  end
end
