require_relative 'stark/reporter/html'

html = Stark::HTML.new

html.format_passing_test("iPhone 5 iOS 11","RACCommandSpec", "_tupleByAddingObject__should_add_a_non_nil_object", "0.001")
html.format_failing_test("iPhone 5 iOS 11", "RACCommandSpec", "enabled_signal_should_send_YES_while_executing_is_YES_and_allowsConcurrentExecutio    n_is_YES", "expected: 1, got: 0")
 
html.format_passing_test("iPad 6 iOS 10.1","ABCComSpec", "_tupleByAddingObject__should_add_a_nil_object", "0.121")
html.format_passing_test("iPad 6 iOS 10.1","RACCommandSpec", "_tupleByAddingObject__should_add_a_nil_object", "0.121")

html.format_passing_test("iPhone 8 iOS 10.1","ABCComSpec", "_tupleByAddingObject__should_add_a_nil_object", "0.121")
html.format_passing_test("iPhone 8 iOS 10.1","RACCommandSpec", "_tupleByAddingObject__should_add_a_nil_object", "0.121")
html.write_report

