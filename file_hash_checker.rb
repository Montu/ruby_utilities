# Author: Akshay Bhardwaj
# Copyright 2013 Akshay Bhardwaj
#
# Ruby Utilites: Range of ruby utlities
#
# This file is part of Ruby Utilities
#
# Ruby Utilities is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'digest/sha2'

class FileHashChecker
	attr_reader :file_name
	def initialize file_name
		@file_name = file_name
	end

	def method_missing method_name, *args
		method_name = method_name.to_s
		return nil unless method_name =~ /calculate_sha\d{3}\z/
		return Digest::SHA256.new.file file_name if method_name.split('_').last == 'sha256'
		return Digest::SHA384.new.file file_name if method_name.split('_').last == 'sha384'
		return Digest::SHA512.new.file file_name if method_name.split('_').last == 'sha512'
	end
end

if FileHashChecker.new(ARGV.first).calculate_sha256  == ARGV.last
	puts 'Match'
else
	puts 'No Match'
end
