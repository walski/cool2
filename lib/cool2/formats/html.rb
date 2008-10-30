require 'cool2/output_parser'
require 'cool2/paragraphizer'
require 'cgi'

module Cool2
  class HTML < OutputParser
    include Cool2::Paragraphizer
    
    def self.container(inner_content, options = {})
      title         = CGI::escapeHTML(options[:title] || 'No Title')
      encoding      = options[:encoding] || 'UTF-8'
      
      <<-eos
      <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

      <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <meta http-equiv="Content-type" content="text/html; charset=#{encoding}"/>
        <title>#{title}</title>
      </head>
      <body>
        #{inner_content}
      </body>

      </html>
      eos
    end
    
    def self.parse_text(text)
      "<p>#{escape(text.to_s.chomp)}</p>\n"
    end
    
    def self.parse_title(title)
      "<h1>#{escape(title)}</h1>\n"
    end
    
    def self.parse_subtitle(subtitle)
      "<h2>#{escape(subtitle)}</h2>"
    end
    
    def self.parse_list(list)
      "<ul>\n" +
      "<li>#{parse_content(list)}</li>\n" +
      "</ul>"
    end
    
    private
    def self.escape(content)
      CGI::escapeHTML(content.to_s)
    end
    
  end
end