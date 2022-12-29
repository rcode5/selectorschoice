# frozen_string_literal: true

module TagsHelper
  def render_tag(tag_contents, html_opts = {})
    tag.span tag_contents, **html_opts
  end

  def render_tag_link(tag_contents, anchor_html_opts = {}, span_html_opts = {})
    tags = (params[:tags] || '').split ','
    tags << tag_contents
    tags = tags.uniq.compact.sort
    anchor_html_opts[:href] = root_path(tags: tags.join(',')) if anchor_html_opts[:href].blank?
    anchor_html_opts[:class] = [[anchor_html_opts[:class] || ''], 'tag'].flatten.join(' ')
    if anchor_html_opts[:href].present?
      tag.a(**anchor_html_opts) do
        render_tag(tag_contents, span_html_opts)
      end
    else
      render_tag(tag_contents, span_html_opts)
    end
  end

  def render_remove_tag_link(tag_contents, anchor_html_opts = {}, span_html_opts = {})
    tags = (params[:tags] || '').split ','
    tags = (tags - [tag_contents]).uniq.compact.sort
    opts = {}

    if anchor_html_opts[:href].blank?
      opts = { tags: tags.join(',') } if tags.present?
      anchor_html_opts[:href] = root_path(opts)
    end
    anchor_html_opts[:class] = [[anchor_html_opts[:class] || ''], 'tag'].flatten.join(' ')
    if anchor_html_opts[:href].present?
      tag.a anchor_html_opts do
        render_tag(tag_contents, span_html_opts)
      end
    else
      render_tag(tag_contents, span_html_opts)
    end
  end
end
