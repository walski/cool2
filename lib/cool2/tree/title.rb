module Cool2
  module Tree
    class Title < Object
      def self.pattern
        /^\s*= (.*) =\s*$/
      end
      
      def process(line, stack)
        @content = line.gsub(self.class.pattern, '\1').strip
      end
      
      def self.responsible?(line)
        line.match(pattern)
      end
    end
  end
end