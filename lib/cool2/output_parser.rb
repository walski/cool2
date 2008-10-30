module Cool2
  class OutputParser < Parser
    def self.write(content, file_name)
      File.open(file_name, 'w') do |file|
        file.puts self.parse(content)
      end
    end
  end
end