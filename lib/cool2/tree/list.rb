module Cool2
  module Tree 
    class List < Object
      PATTERN = /^(\s*)- /
      
      def process(line, stack)
        @content = Array.new

        line = line.gsub(PATTERN, '')
        start_indentation = $1.size + 2
        
        @content << Text.new(line)
        
        work_space = ''
        while line = stack.shift
          if indentation(line) >= start_indentation
            work_space += "#{line[start_indentation..-1]}\n"
          else
            stack.unshift(line)
            break
          end
        end
        
        parser = Cool2::Parser.new(work_space.chomp)
        @content += parser.tree.content
      end
      
      def self.responsible?(line)
        line.match PATTERN
      end
      
      private
      def indentation(text)
        return unless text.match(/^(\s*)/)
        $1.size
      end
      
    end
  end
end