module TagsHelper

  def render_tag(t,html_opts = {})
    content_tag "span", t, html_opts
  end

  def render_tag_link(t, anchor_html_opts = {}, span_html_opts = {}) 
    tags = (params[:tags] || '').split ','
    tags << t
    tags = tags.uniq.compact.sort
    if !anchor_html_opts[:href].present?
      anchor_html_opts[:href] = root_path(tags: tags.join(","))
    end
    anchor_html_opts[:class] = [[anchor_html_opts[:class] || ''], 'tag'].flatten.join(' ')
    if anchor_html_opts[:href].present?
      content_tag 'a', anchor_html_opts do 
        render_tag(t, span_html_opts)
      end
    else
      render_tag(t, span_html_opts)
    end

  end

  def render_remove_tag_link(t, anchor_html_opts = {}, span_html_opts = {}) 
    tags = (params[:tags] || '').split ','
    tags = (tags - [t]).uniq.compact.sort
    opts = {}

    if !anchor_html_opts[:href].present?
      opts = {tags: tags.join(",")} if tags.present?
      anchor_html_opts[:href] = root_path(opts)
    end
    anchor_html_opts[:class] = [[anchor_html_opts[:class] || ''], 'tag'].flatten.join(' ')
    if anchor_html_opts[:href].present?
      content_tag 'a', anchor_html_opts do 
        render_tag(t, span_html_opts)
      end
    else
      render_tag(t, span_html_opts)
    end

  end

end  

    
    
