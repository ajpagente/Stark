<p align="center">
  <img src="stark.png" width="350" max-width="90%" alt="Stark" />
</p>

## Generate test reports with ease
Stark is a test report generator that takes test results in csv format and generates an HTML report. The report template and code is based on [xcpretty](https://github.com/xcpretty/xcpretty). However, unlike xcpretty that is designed to use with xcodebuild, Stark is independent of development platform. You can generate any test report from a csv defined in a specific format.

## Installation
NOTE: Stark only supports macOS and Linux at the moment.

Clone or download Stark from [this](https://github.com/ajpagente/Stark) repository.
Set your path to point to *Stark/bin* as shown.
```
$ export PATH=$PATH:~/Desktop/Stark/bin
``` 

You are now ready to use Stark from the terminal.
## Usage
### Stark options
```
$ stark -h
stark -p PRODUCT -i FOLDERPATH
    -i, --input FOLDERPATH           The folder where Stark searches for csv files to parse.
    -o, --output FILE.html           The html test report. If not specified, tests.html is generated in the current directory.
    -p, --product PRODUCT            The name of the product. Typically it includes the OS and version. Example: Stark iOS 1.2.3
    -h, --help                       Show this message
    -v, --version                    Show version
```

### Example
```
$ stark -p "ABC iOS 1.2.3" -i "test_result" -o "ABCTestReport.html"
```

## How it works
### Parsing csv
Stark searches for file with .csv extension in FOLDERPATH. Stark then parses each csv file to extract the test results and generates an html report.

### csv checks
csv check covers the following:
* The file is utf-8 encoded
* The header matches the required format
* The test result uses a comma separator
* The test result has number of items matching the number of header items

### Valid header
Refer to **samples/template.csv** for the header format

### Product match
The product specified in the command-line option has to match the product in the test result. Any non-matching test result will be skipped.

The match is not case-sensitive and white space is ignored in the comparison. Some examples given below to illustrate how product matching works.
```
Example: -p "ABC iOS 1.2.3"
"ABC iOS 1.2.3" => match
"abc iOS 1.2.3" => match
"ABCiOS1.2.3" => match
"ABC iOS 1.2.4" => does not match
```
## Wishlist
* Notes section in the report - enables free form notes (ex. env config)
* Windows support
* Improve error messages
* Add logs
