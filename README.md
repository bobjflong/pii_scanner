# pii-scanner

Scans samples of Rails models for PII. The initial version just has a very simple matcher for emails.

## Config

* scope - how to sample your models for scanning. Must return an Enumerable. Examples:
  * `-> (x) { x.last(100 } # to check for recent examples`
  * `-> (x) { x.offset(rand(x.count) - 10).limit(10) } # to find random examples`


* models - which models to check

* test_cases - subclasses of `PiiScanner::TestCases::TestCase`
  * a basic `EmailAddress` test case is included

## Output


```ruby
scan = PiiScanner::Scan.new(
  scope: -> (x) { x.last(100) },
  models: [User],
  test_cases: [PiiScanner::TestCases::EmailAddress]
)
puts scan.report
```

```
+-------------------+-------+-----------------------------------+
| Class name        | Pass  | Reason                            |
+-------------------+-------+-----------------------------------+
| User              | false | 'bob@foo.com' looks like an email |
+-------------------+-------+-----------------------------------+
```
