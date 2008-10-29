module Cool2
  module Tree
    class Object
      attr_accessor :content
      
      def initialize(*attributes)
        @content = Array.new
        
        send(:process, *attributes) if respond_to?(:process)
      end
      
      def <<(obj)
        @content << obj
      end
      
      def ==(other)
        @content == other.content
      end
      
      def self.responsible?(line)
        false
      end
    end
  end
end