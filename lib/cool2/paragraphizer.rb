module Cool2
  module Paragraphizer
    def paragraphize!
      return unless @tree.content.respond_to? :each
      
      @tree = paragraphize(@tree)
    end
    
    private
    def paragraphize(tree)
      last_text = nil
      result = Array.new
      tree.content.each do |child|
        case child
        when Cool2::Tree::Text
          last_text = nil and next if child.content.strip.empty?
          
          if last_text
              last_text.content << "\n#{child.content}"
              last_text.content.gsub!(/^\n*/, '')
          else
            last_text = child
            result << child
          end
        when Cool2::Tree::List
          child.content = paragraphize(child).content
          result << child
        else
          result << child
        end
      end
        
      tree.content = result
      tree
    end
  end
end