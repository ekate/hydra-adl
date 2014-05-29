module ApplicationHelper

  book_viewer= "/catalog"

  def render_external_link args, results = Array.new
    begin
      value = args[:document][args[:field]]
      if value.length > 1
        value.each_index do |index|
          text      = args[:document][blacklight_config.show_fields[args[:field].to_s][:text]][index]
          url       = value[index]
          link_text = text.nil? ? url : text
          results << link_to(link_text, url, { :target => "_blank" })
        end
      else
        text      = args[:document].get(blacklight_config.show_fields[args[:field].to_s][:text])
        url       = args[:document].get(args[:field])
        link_text = text.nil? ? url : text
        results << link_to(link_text, url, { :target => "_blank" })

      end
    rescue
      return nil
    end
    return results.join(field_value_separator).html_safe
  end

  def render_image_from_url args, results = Array.new
    begin
      value = args[:document][args[:field]]
      if value.length > 1
        value.each_index do |index|         
          url       = value[index]       
          results << link_to( image_tag(url, book_viewer) )
        end
      else
        text      = args[:document].get(blacklight_config.show_fields[args[:field].to_s][:text])
        url       = args[:document].get(args[:field])
        link_text = text.nil? ? url : text
       begin
         text2      = args[:document].get('identifier_tesim')
       rescue =>e
       flash[:error] = "#{I18n.translate('letter.letter_create_failed')}<br/>Detailed error: #{e.message}"
    ExceptionNotifier.deliver_exception_notification(e, self, request)
       end         
        results << link_to( image_tag(url),"http://localhost:8983/BookReaderDemo/#{text2}.html",{ :target => "popup" } )
      end
    rescue
      return nil
    end
    return results.join(field_value_separator).html_safe
  end

  def field_value_separator
    tag(:br)
  end
end
