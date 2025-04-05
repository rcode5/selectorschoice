# frozen_string_literal: true

xml.rss('version' => '2.0', 'xmlns:dc' => 'http://purl.org/dc/elements/1.1/',
        'xmlns:itunes' => 'http://www.itunes.com/dtds/podcast-1.0.dtd') do
  xml.channel do
    xml.title('Selectors Choice - Podcast')
    xml.link('https://selectorschoice.bunnymatic.com/')
    xml.description 'Selectors Choice - Podcast'
    xml.language 'en-us'
    xml.ttl '4000'
    xml.pubDate @pub_date.rfc822
    xml.lastBuildDate @last_build_date.rfc822
    xml.itunes :author, 'Selectors Choice'
    xml.itunes :explicit, 'clean'
    xml.itunes :image, href: image_url('podcast_image.png')
    xml.itunes :owner do
      xml.itunes :name, 'Selectors Choice'
    end
    xml.itunes :block, 'no'
    xml.itunes :category, text: 'Music'
    xml.itunes :summary, "This is a collection of recordings by dj's Disco Nap and Mr Rogers. Enjoy"

    @tracks.each do |track|
      xml.item do
        xml.title(track.title)
        xml.description("#{track.description}\n\n#{track.playlist}")
        xml.pubDate((track.recorded_on || track.created_at).rfc822)
        xml.guid(track.signed_url)
        xml.link("https://www.selectorschoice.bunnymatic.com/#{track_path(track)}")
        xml.enclosure(url: track.signed_url, type: 'audio/mpeg')
        xml.tag!('dc:creator', track.author)
        xml.itunes :keywords, [track.tag_list, track.style_list].compact.flatten.sort.uniq.join(', ')
      end
    end
  end
end
