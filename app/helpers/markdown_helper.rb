module MarkdownHelper
  def markdown(text, **options)
    Commonmarker.to_html(text, options: options).html_safe
  end
end
