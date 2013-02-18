module ApplicationHelper

  def link_to_icon icon, link, opts = {}
    if link.present?
      icon_classes = (opts.delete :icon_classes) || nil
      opts[:title] ||= icon
      link_to link, opts do
        content_tag 'i', '', class: ["icon icon-#{icon}",icon_classes].compact.join(" ")
      end
        
    else
      txt
    end
  end

  def link_to_text txt, link, opts = {}
    if link.present?
      link_to txt, link, opts
    else
      txt
    end
  end

  def link_to_image img, link, opts = {}
    if link.present?
      link_to link, opts do
        image_tag img
      end
    else
      image_tag img
    end
  end

  def markup(c)
    RDiscount.new(c).to_html.html_safe
  end
end
