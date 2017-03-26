require "pii_scanner/test_cases/test_case"

module PiiScanner
  module TestCases
    class EmailAddress < PiiScanner::TestCases::TestCase
      def self.passes?(value)
        return true unless value.is_a?(String)
        return [false, "'#{value}' looks like an email"] if value["@"]
        true
      end

      def self.failing_case(models)
        result = nil
        models.find do |model|
          columns = model.column_names.map(&:to_sym)
          values = columns.map { |column| model.send(column) }
          values.find { |value| result = passes?(value) }
          result = [model.class.to_s] + result if result
          result
        end and result
      end
    end
  end
end
