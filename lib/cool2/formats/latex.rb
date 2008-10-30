require 'cool2/output_parser'
require 'cool2/paragraphizer'

module Cool2
  class Latex < OutputParser
    include Cool2::Paragraphizer
    
    def self.container(inner_content, options = {})
      title          = options[:title] || ''
      encoding       = options[:encoding] || 'utf8'
      document_class = options[:document_class] || 'article'

      <<-eos
      \\documentclass{#{document_class}}
      \\usepackage[#{encoding}]{inputenc}
      \\usepackage[T1]{fontenc}

      \\title{#{title}}
      \\begin{document}
        #{inner_content}
      \\end{document}
      eos
    end
    
    def self.parse_text(text)
      "#{text.to_s.chomp}\n\n"
    end
    
    def self.parse_title(title)
      "\\section{#{title}}\n"
    end
    
    def self.parse_subtitle(subtitle)
      "\\subsection{#{subtitle}}\n"
    end
    
    def self.parse_list(list)
      "\\begin{itemize}\n" +
      "\\item #{parse_content(list)}\n" +
      "\\end{itemize}"
    end
    
  end
end