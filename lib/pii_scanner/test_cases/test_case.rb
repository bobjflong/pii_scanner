module PiiScanner
  module TestCases
    class TestCase
      def self.passes?(_)
        fail NotImplemented
      end

      def self.failing_case(_)
        fail NotImplemented
      end
    end
  end
end
