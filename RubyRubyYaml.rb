require 'yaml'

def sort_second_level(data)
  data.transform_values do |value|
    if value.is_a?(Hash)
      value.sort.to_h
    else
      value
    end
  end
end

while true
  puts "Please enter the full file path."
  path = gets.chomp
  if path.empty?
    puts "You need to input something!"
    next
  end

  begin
    # Read the YAML file
    content = File.read(path)
    data = YAML.load(content)

    # Sort the data
    sorted = sort_second_level(data)

    # Write back to the file
    yaml_options = {
      indentation: 2,
      line_width: -1,
      canonical: false
    }

    File.open(path, 'w') do |file|
      file.write(sorted.to_yaml(yaml_options))
    end

    puts "YAML file successfully sorted and saved!"
    break
  rescue Psych::SyntaxError => e
    puts "Invalid YAML: #{e.message}"
    puts "Please try again!"
  rescue Errno::ENOENT
    puts "File not found. Please check the path and try again."
  rescue => e
    puts "An error occurred: #{e.message}"
    puts "Please try again!"
  end
end