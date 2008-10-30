module Cool2
  class OutputParser < Parser
    def self.write(content, file_name)
      File.open(file_name, 'w') do |file|
        file.puts self.parse(content)
      end
    end
    def self.parse(string, options = {})
      parser = self.new(string)
      parser.paragraphize! if parser.respond_to? :paragraphize!

      content = parse_content(parser.tree.content)
      content = container(content, options) if respond_to?(:container)
      content
    end

    protected
    def self.parse_content(content)
      result = ''
      content.each do |child|
        content = child.instance_of?(String) ? child : child.content
        method  = "parse_#{child.class.name.split('::').last.camelize}".to_sym
        content = send(method, content) if respond_to?(method)
        
        result << content
          
        # 
        # case child
        # when Tree::Text
        #   result << block_add("#{child.content.chomp}\n\n", &blk)
        # when Tree::Title
        #   result << block_add("\\section{#{child.content}}\n", &blk)
        # when Tree::Subtitle
        #   result << block_add("\\subsection{#{child.content}}\n", &blk)
        # when Tree::List
        #   result << "\\begin{itemize}\n\\item "
        #   result << parse_content(child.content)
        #   result << "\\end{itemize}\n"
        # end
      end

      result
    end
  end
end