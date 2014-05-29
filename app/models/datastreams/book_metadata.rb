class BookMetadata < ActiveFedora::OmDatastream

  set_terminology do |t|
    t.root(path: "fields")
    t.title(path: "titleInfo.title")
    t.title_roman(path: "titleInfo.title")
    t.author
  end

  def self.xml_template
    Nokogiri::XML.parse("<fields/>")
  end

  def prefix
    # set a datastream prefix if you need to namespace terms that might occur in multiple data streams
    ""
  end

end
