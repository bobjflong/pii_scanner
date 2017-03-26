module PiiScanner
  class Config
    attr_reader :scope, :models, :test_cases

    def initialize(scope:, models:, test_cases: [])
      @scope = scope
      @models = models
      @test_cases = test_cases
    end

    def scope_results
      Enumerator.new do |y|
        models.each do |model|
          results = scope.call(model)
          if !results.is_a?(Enumerable)
            fail "result of scope call on #{model} was not enumerable"
          end
          y << results
        end
      end
    end
  end
end
