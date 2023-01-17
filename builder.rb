require 'kramdown'
require 'fileutils'

OUTPUT_DIRECTORY = "./output"
INPUT_DIRECTORY = "./input"

def check_directories
  return "Output directory does not exist." unless File.directory? OUTPUT_DIRECTORY
  return "Input directory does not exist." unless File.directory? INPUT_DIRECTORY
end

def output_filename(input_filename)
  period_index = input_filename.index(".")
  input_filename[0..period_index] + "html"
end

file_name = ARGV[0]

puts "Copying #{file_name} to input directory."
FileUtils.cp(file_name, "#{INPUT_DIRECTORY}/#{file_name}")

puts "Reading input file."
input = File.read(file_name)

puts "Converting input to HTML."
output = Kramdown::Document.new(input).to_html

puts "Writing HTML to #{OUTPUT_DIRECTORY}"
File.write("#{OUTPUT_DIRECTORY}/#{file_name.sub(/\.md/, ".html")}", output)
