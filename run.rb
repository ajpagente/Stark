require_relative 'stark/reporter/html'
require_relative 'stark/parser/csvparser'

html = Stark::HTML.new('TMD iOS 2.3.1')
parser = Stark::CSVParser.new(html)
parser.parse('test.csv')
parser.reporter.write_report
