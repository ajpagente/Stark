require 'csv'

module Stark
  class CSVParser
    VALID_HEADER="\"product\",\"platform\",\"testsuite\",\"test\",\"time\",\"reason\",\"status\""
    SEP = ','
    COLUMN_COUNT = 7
 
    attr_reader :reporter
    
    def initialize(reporter)
      @reporter = reporter
    end

    def parse(filename)
      @filename = filename
      return false unless is_valid_csv?
      table = CSV.parse(File.read(@filename), headers:true)
      # populate reporter with tests
      table.each do |test|
        next if not is_target_product?(test["product"])
        status = test["status"]
        # strip removes the newline after status
        if status.strip.eql?('PASS')
          reporter.format_passing_test(test["platform"],
                                       test["testsuite"],
                                       test["test"],
                                       test["time"]
                                      )
        else
          reporter.format_failing_test(test["platform"],
                                       test["testsuite"],
                                       test["test"],
                                       test["reason"])
        end
      end       
      return true
    end

    private

    def is_target_product?(product)
      product_in_csv = strip_string(product).downcase
      product_in_reporter = strip_string(reporter.product).downcase
      return true if product_in_reporter.eql?(product_in_csv)
      return false
    end

    def is_valid_header?(header)
      header = strip_string(header)
      if header.downcase.eql?(VALID_HEADER.downcase)
        return true
      end
      return false
    end

    def is_valid_csv?()
      content = File.read(@filename, :encoding => 'utf-8')
      if content.valid_encoding?
        line_num = 1
        content.each_line{ |line|
          if line_num == 1
            if not is_valid_header?(line)
              puts "Invalid header"
              return false
            end
          end
          if line.count(SEP) < COLUMN_COUNT-1
            puts "Invalid separator at #{line_num}"
            return false
          end
          line_num += 1
        }
      else
        puts 'Invalid encoding'
        return false
      end
      return true
    end   

    def strip_string(string)
      return string.gsub(/\s+/,"")
    end 
  end
end
