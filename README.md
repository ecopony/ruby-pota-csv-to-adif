# ruby-pota-csv-to-adif
Converts a CSV file of a Parks on the Air log to ADIF

## Overview

This is a very simple conversion tool for Ham radio operators to use to convert a CSV log file of a POTA activation to the ADIF file format required by the Parks on the Air program.

The basic flow:
* Log contacts in a spreadsheet (Excel, Google Sheets, etc.) using the designated set of headers
* Export the file to CSV
* Run this converter
* Send the converted file to your regional POTA admin

This converter is pretty simple, but follow the conventions and everything should be fine!

## Installation

### Prerequisites

* Ruby (https://www.ruby-lang.org/en/downloads/)
* Ruby gems (https://rubygems.org/pages/download, but you probably already have it if you've installed Ruby, check first by running `gem --version`)

### Install the ruby-pota-csv-to-adif gem

`gem install ruby-pota-csv-to-adif`

## How to use

* Create a spreadsheet with the following headers:
    * CALL
    * QSO_DATE
    * TIME_ON
    * BAND
    * MODE
    * OPERATOR
    * MY_SIG_INFO
    * SIG_INFO
    * STATION_CALLSIGN
* Log contacts using the formats defined by the Parks on the Air documentation as this converter performs no validation or conversion of values. What you enter is what will come out!
* Export the spreadsheet to CSV, naming it with the file-name format requested by your regional administrator (e.g., KJ7LOW@K-2850_20210221.csv) 
* In a terminal window, run the converter, passing it the path to your CSV file
* If no errors occur, the converted ADI file will now be in the same directory as the source CSV file 

_Note: Other headers/columns may appear in your spreadsheet, but they will be ignored. If you want to include FREQUENCY for example, go right ahead. It won't be included in the final output. The final output is limited to only the fields that the POTA admins want to see._

_Also note: The header MY_SIG is always `POTA`. You can include this column in your spreadsheet or not. It'll always appear s `POTA` in the final product._

### Example

```
$ ruby-pota-csv-to-adif ~/pota-logs/KJ7LOW@K-2850_20210221.csv
$ ls -l ~/pota-logs
total 16
-rw-r--r--  1 edcopony  staff  2280 Feb 27 11:45 KJ7LOW@K-2850_20210221.adi
-rw-r--r--  1 edcopony  staff   873 Feb 27 11:36 KJ7LOW@K-2850_20210221.csv
```

