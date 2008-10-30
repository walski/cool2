require 'cool2/output_parser'
require 'cool2/paragraphizer'

module Cool2
  class Latex < OutputParser
    include Cool2::Paragraphizer
    
    def self.parse(string)
      parser = self.new(string)
      parser.paragraphize!
      
      parse_content(parser.tree.content)
    end
    
    private
    def self.parse_content(content, &blk)
      result = ''
      content.each do |child|
        case child
        when Tree::Text
          result << block_add("#{child.content.chomp}\n\n", &blk)
        when Tree::Title
          result << block_add("\\section{#{child.content}}\n", &blk)
        when Tree::Subtitle
          result << block_add("\\subsection{#{child.content}}\n", &blk)
        when Tree::List
          result << "\\begin{itemize}\n"
          result << parse_content(child.content) do |middle_part|
            "\\item #{middle_part.chomp}"
          end
          result << "\\end{itemize}\n"
        end
      end

      result
    end
    
    def self.block_add(content, &blk)
      return content unless blk
      blk.call(content)
    end
  end
end