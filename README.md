<p align="center">
  <img src="doc-assets/stark.png" width="350" max-width="90%" alt="Stark" />
</p>

## Generate test reports with ease
Stark is a test report generator that takes test results in csv format and generates an HTML report. The report template and code is based on [xcpretty](https://github.com/xcpretty/xcpretty). However, unlike xcpretty that is designed to use with xcodebuild, Stark is independent of development platform. You can generate any test report from a csv defined in a specific format.

## Installation
:information_source: Stark only supports **macOS** and **Linux**.

Clone or download Stark from [this](https://github.com/ajpagente/Stark) repository then
set `PATH` to point to *Stark/bin* as shown.
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
:point_right: **--product** and **--input** are mandatory options
### Example
```
$ stark -p "ABC iOS 1.2.3" -i test_result -o ABCTestReport.html
```

## Test Report
The following are screenshots of a test report generated with [sample-results](https://github.com/ajpagente/Stark/sample-results)

<p>
  <img src="doc-assets/report-all.png" width="350" max-width="90%" alt="Stark" />
</p>


## How it works
### Parsing csv
Stark searches for files with .csv extension in FOLDERPATH. Stark then parses each csv file to extract the test results and generate an HTML report.

### csv checks
The csv check includes the following:
* The file is utf-8 encoded
* The header matches the required format
* The test result uses a comma separator
* The test result has number of items matching the number of header items

### Valid header
Refer to **samples/template.csv** for the header format.

### Product matching
The product specified in the command-line option has to match the product in the test result. Any non-matching test result will be skipped.

Product matching is not case-sensitive and white space is ignored. Some examples are given below to illustrate how product matching works.
```
Example: -p "ABC iOS 1.2.3"
"ABC iOS 1.2.3" => match
"abc iOS 1.2.3" => match
"ABCiOS1.2.3" => match
"ABC iOS 1.2.4" => does not match
```

### Test Notes
A notes section is shown at the beginning of the test results. The notes field can be used to provide addional information such as test environment, application configuration tested, and pretty much anything you want.

The notes are read from the file named **notes.sta** which must be located in the same directory as the test csv.

The notes are text-based with html tags for text formatting. There is no pre-processing of the file. The notes.sta content is read and inserted to the notes section. 

## Wishlist
* Windows support
* Improve error messages
* Verbose logs
* Use product from test result (-p becomes optional)
