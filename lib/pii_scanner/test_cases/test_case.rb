module PiiScanner
  module TestCases
    class TestCase
      def self.passes?(_)
        fail NotImplemented
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
