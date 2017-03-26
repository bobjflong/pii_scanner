require "pii_scanner/test_cases/test_case"

module PiiScanner
  module TestCases
    class EmailAddress < PiiScanner::TestCases::TestCase
      def self.passes?(value)
        return true unless value.is_a?(String)
        return [false, "'#{value}' looks like an email"] if value["@"]
        true
      end
    end
  end
end
