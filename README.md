<p align="center">
  <img src="stark.png" width="350" max-width="90%" alt="Stark" />
</p>

## Generate test reports with ease
Stark is a test report generator that takes test results in csv format and generates an HTML report. The report template and code is based on [xcpretty](https://github.com/xcpretty/xcpretty). However, unlike xcpretty that is designed to use with xcodebuild, Stark is independent of development platform. You can generate any test report from a csv defined in a specific format.

## Usage
NOTE: Stark only supports macOS and Linux at the moment.

Clone or download Stark from [this](https://github.com/ajpagente/Stark) repository.

Set your path to point to *Stark/bin* as shown.
```
$ export "~/Desktop/Stark/bin:$PATH"
``` 

Stark options
```
$ stark -h
stark -p PRODUCT -i FOLDERPATH
    -i, --input FOLDERPATH           The folder where Stark searches for csv files to parse.
    -o, --output FILE.html           The html test report. If not specified, tests.html is generated in the current directory.
    -p, --product PRODUCT            The name of the product. Typically it includes the OS and version. Example: Stark iOS 1.2.3
    -h, --help                       Show this message
    -v, --version                    Show version
```


## Wishlist
* Windows support
* Add logs
