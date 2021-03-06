module Cool2
  require 'cool2/tree'
  
  class Parser
    FORMAT_MODULES = [Tree::Title, Tree::Subtitle, Tree::List, Tree::Text]
    
    attr_reader :tree
    
    def initialize(content)
      @stack = content.split("\n")
      @tree = parse
    end
    
    def parse
      tree = Tree::Root.new
      
      while !@stack.empty?
        line = @stack.shift
        format = FORMAT_MODULES.select{|format| format.responsible?(line)}.first
        tree.content << format.new(line, @stack)
      end
      
      tree
    end
    
  end
end