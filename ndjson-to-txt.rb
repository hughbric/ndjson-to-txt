#!/usr/bin/env ruby
require 'json'
require 'open-uri'

def read_file(file_path)
  file = open(file_path)
  output_file = open('./output.txt', 'w')
  all_titles = []

  file.each do |line|
    json_line = JSON.parse(line)

    if json_line['_type'] == 'post'
      all_titles << json_line['title']
      output_file.puts '------------------------------------------------------------'
      output_file.puts 'Title: ' + json_line['title']
      output_file.puts 'Slug: ' + json_line['slug']['current']
      output_file.puts 'Created at: ' + json_line['_createdAt']
      output_file.puts 'Updated at: ' + json_line['_updatedAt']
      output_file.puts '------------------------------------------------------------'
      output_file.puts "\n"

      json_line['body'].each do |section|
        next if section['_type'] != 'block'
        paragraph = ''

        section['children'].each do |text_node|
          paragraph += text_node['text']
        end

        if paragraph != ''
          output_file.puts paragraph
          output_file.puts "\n"
        end
      end
    end
  end

  output_file.puts '------------------------------------------------------------'
  output_file.puts 'INDEX'
  output_file.puts '------------------------------------------------------------'
  output_file.puts "\n"
  output_file.puts 'Total number of blogs: ' + all_titles.size.to_s
  output_file.puts "\n"
  output_file.puts 'List of all the titles:'
  output_file.puts "\n"

  all_titles.each_with_index do |title, i|
    output_file.puts "#{i + 1}: #{title}"
  end
  output_file.puts "\n"
  output_file.puts '------------------------------------------------------------'
  output_file.puts "\n"
  output_file.puts "End of file."
end

if $0 == __FILE__
  raise ArgumentError, "Usage: #{$0} ./data.ndjson" unless ARGV.length == 1
  raise ArgumentError, "File type not supported. Must be: .ndjson" unless ARGV[0].split('.').last == 'ndjson'
  read_file(ARGV[0])
end
