# frozen_string_literal: true

module ApplicationHelper
  def link_to_icon(icon, link, opts = {})
    icon_classes = (opts.delete :icon_classes) || nil
    icon_tag = tag.i '', class: ["icon icon-#{icon}", icon_classes].compact.join(' ')

    if link.present?
      opts[:title] ||= icon.to_s.humanize
      link_to link, opts do
        icon_tag
      end
    else
      icon_tag
    end
  end

  def link_to_dark_icon(icon, link, opts = {})
    icon_classes = (opts.delete :icon_classes) || []
    link_to_icon icon, link, opts.merge(icon_classes: icon_classes + ['black'])
  end

  def link_to_text(txt, link, opts = {})
    if link.present?
      link_to txt, link, opts
    else
      txt
    end
  end

  def link_to_image(img, link, opts = {})
    if link.present?
      link_to link, opts do
        image_tag img
      end
    else
      image_tag img
    end
  end

  def markup(content)
    RDiscount.new(content).to_html.html_safe
  end
end
