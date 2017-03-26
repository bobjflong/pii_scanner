require "minitest/autorun"
require "pii_scanner/scan"
require "pii_scanner/test_cases/email_address"

class Model
  def self.test_scope
    [:foo]
  end
end

class FailingModel
  def self.test_scope
    fail
  end
end

class RailsRowWithEmail
  def column_names
    [:email]
  end

  def email
    "bob@foo.com"
  end
end

class RailsModelWithEmail
  def self.test_scope
    [::RailsRowWithEmail.new]
  end
end

class TestScan < Minitest::Test
  def test_scope
    scope = -> (x) { x.test_scope }
    scan = PiiScanner::Scan.new(
      scope: scope,
      models: [Model]
    )
    assert_equal [:foo], scan.scope_results.first
  end

  def test_scope_laziness
    scope = -> (x) { x.test_scope }
    scan = PiiScanner::Scan.new(
      scope: scope,
      models: [Model, FailingModel]
    )
    assert_equal [:foo], scan.scope_results.first
  end

  def test_email_case
    scope = -> (x) { x.test_scope }
    scan = PiiScanner::Scan.new(
      scope: scope,
      models: [RailsModelWithEmail],
      test_cases: [PiiScanner::TestCases::EmailAddress]
    )
    scan.scan!
    assert_equal true, scan.failed?
    assert_equal ["RailsRowWithEmail", false, "'bob@foo.com' looks like an email"], scan.errors.flatten
  end
end
