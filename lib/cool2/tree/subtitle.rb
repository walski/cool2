module Cool2
  module Tree
    class Subtitle < Title
      def self.pattern
        /^\s*== (.*) ==\s*$/
      end
    end
  end
end
      