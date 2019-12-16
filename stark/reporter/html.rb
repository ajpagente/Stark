require 'erb'
require 'fileutils'
require 'pathname'

module Stark
  class HTML
    FILEPATH = 'tests.html'
    TEMPLATE = 'assets/report.html.erb'
    
    def initialize
      @product = 'TMD iOS 2.4.1'
      @test_platforms = {}
      @test_suites = {}
      @platform_count = 0
      @platform_fail_count = 0
      @test_count = 0
      @fail_count = 0
    end

    def format_passing_test(platform, suite, test_case, time)
      add_test(platform, suite, name: test_case, time: time, screenshots: [])
    end
   
    def format_failing_test(platform, suite, test_case, reason)
      add_test(platform, suite, name: test_case, failing: true,
                                reason: reason, screenshots: [])
    end

    def add_test(platform_name, suite_name, data)
      @test_platforms[platform_name] ||= {}
      @test_platforms[platform_name][suite_name] ||= {tests: []}
      @test_platforms[platform_name][suite_name][:tests] << data
      if data[:failing]
        @test_platforms[platform_name][:failing] = true
        @test_platforms[platform_name][suite_name][:failing] = true
      end
    end

    def count_failing_platforms()
      @test_platforms.each do |platform, test_suites|
        test_suites.key?(:failing) ? @platform_fail_count += 1 : next
      end
    end  

    def count_tests_per_platform
      @test_platforms.each do |platform, test_suites|
        test_count = 0
        fail_count = 0
        next if platform.is_a?(Symbol)
        test_suites.each do |suite, info|
          next if suite.is_a?(Symbol)
          test_count +=  info[:tests].size
          info.each do |key, tests|
            next unless tests.is_a?(Array)
            tests.each do |test|
              next if test.is_a?(Symbol)
              if test.key?(:failing)
                fail_count += 1
              end
            end
          end
        end
        @test_platforms[platform][:test_count] = test_count
        @test_platforms[platform][:fail_count] = fail_count
      end
    end

    def write_report
      File.open(FILEPATH, 'w') do |f|
         product = @product
         test_platforms = @test_platforms
         platform_count = @test_platforms.size
         count_failing_platforms
         platform_fail_count  = @platform_fail_count
         count_tests_per_platform
         erb = ERB.new(File.open(TEMPLATE, 'r').read)
         f.write erb.result(binding)
      end
    end

  end
end
