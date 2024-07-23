require "html_pipeline/convert_filter/markdown_filter"

module MarkdownHelper
  def markdown(text, pipeline: nil)
    pipeline ||= HTMLPipeline.new(convert_filter: HTMLPipeline::ConvertFilter::MarkdownFilter.new)
    pipeline.call(text)[:output].html_safe
  end
end
