require 'rouge'
require 'rouge/plugins/redcarpet'

module ApplicationHelper
  class RougeRender < Redcarpet::Render::HTML
    def block_code(code, language)
      lexer = Rouge::Lexer.find_fancy(language || 'plaintext', code) || Rouge::Lexers::PlainText
      formatter = Rouge::Formatters::HTMLLegacy.new(css_class: 'highlight')
      formatted_code = formatter.format(lexer.lex(code))
      <<~HTML
        <div class="relative group">
          <button class="absolute top-2 right-2 opacity-0 group-hover:opacity-100 transition-opacity bg-gray-800 text-white text-xs px-2 py-1 rounded copy-btn" onclick="copyCode(this)">Copy</button>
          <div class="highlight">
            #{formatted_code}
          </div>
        </div>
      HTML
    end
  end
  def markdown(text)
    rouge_renderer = RougeRender.new(filter_html: true, hard_wrap: true)
    options = { fenced_code_blocks: true, autolink: true, lax_html_blocks: true }
    markdown_to_html = Redcarpet::Markdown.new(rouge_renderer, options)
    markdown_to_html.render(text).html_safe
  end
end
def root_page?
  current_page?(root_path)
end
def og_image_path
  "https://ruby.cjtsai.com/og"
end  
def og_url_path
  if defined?(@user) && @user.present? && @user.id
    user_blog_posts_url(@user)
  elsif defined?(@blog_post) && @blog_post.present? && @blog_post.id
    blog_post_url(@blog_post)
  else
    request.original_url
  end
end

def og_title_name
  if root_page?
    "cjtsai的TOI日記"
  elsif @blog_post.present?
    @blog_post.title
  else
    if @user.present? && @user.id
      @user.username+"'s Blog Posts"
    else
      "All Blog Posts"
    end
  end
end

def og_des
  if @blog_post.present? && @blog_post.id
    @blog_post.body[0,100]
  else
    "a very cool website made by cjtsai"
  end
end
