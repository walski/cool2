module Cool2
  module Tree
    class Text < Object
      def process(line, stack = nil)
        @content = line
      end
      
      def self.responsible?(line)
        true
      end
    end
  end
end