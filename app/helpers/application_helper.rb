require 'rouge'
require 'rouge/plugins/redcarpet'

module ApplicationHelper
  class RougeRender < Redcarpet::Render::HTML
    def block_code(code, language)
      lexer = Rouge::Lexer.find_fancy(language || 'plaintext', code) || Rouge::Lexers::PlainText
      formatter = Rouge::Formatters::HTMLLegacy.new(css_class: 'highlight')
      # Wrap the formatted code in a div explicitly.
      formatted_code = formatter.format(lexer.lex(code))
      "<div class=\"highlight\">#{formatted_code}</div>"
    end
  end
  def markdown(text)
    rouge_renderer = RougeRender.new(filter_html: true, hard_wrap: true)
    options = { fenced_code_blocks: true, autolink: true, lax_html_blocks: true }
    markdown_to_html = Redcarpet::Markdown.new(rouge_renderer, options)
    markdown_to_html.render(text).html_safe
  end
end

