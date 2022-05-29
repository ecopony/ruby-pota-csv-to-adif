# Copyright (c) 2021-2022 Edward Copony
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require 'csv'

module PotaCsvToAdif
  class LogFile
    def initialize(file_path)
      @file_path = file_path
    end

    def convert
      file = File.open(file_path)
      csv = CSV.new(file, headers: true)
      File.open("#{file_path[0...file_path.rindex('.')]}.adi", 'w') do |adif_file|
        adif_file.puts header

        csv.each do |row|
          adif_file.puts "#{field('CALL', row)}#{field('QSO_DATE', row)}#{field('TIME_ON', row)}#{field('BAND', row)}#{field('MODE', row)}#{field('OPERATOR', row)}<MY_SIG:4>POTA #{field('MY_SIG_INFO', row)}#{field('SIG_INFO', row)}#{field('STATION_CALLSIGN', row)}<EOR>"
        end
      end
    end

    private

    attr_reader :file_path

    def header
      <<-ADIF_HEAD
ADIF Export from ruby-pota-csv-to-adif v[0.3]
https://github.com/ecopony/ruby-pota-csv-to-adif
Copyright (C) 2021-2022 Edward Copony
File generated on #{Time.now.getutc.strftime('%d %b, %Y at %I:%M')}
<ADIF_VER:5>3.1.0
<PROGRAMID:21>ruby-pota-csv-to-adif
<PROGRAMVERSION:3>0.3
<EOH>

      ADIF_HEAD
    end

    def field(name, row)
      value = row[name]&.strip
      return if value.nil?
      "<#{name.upcase}:#{value.size}>#{value} "
    end
  end
end
