class Datastreams::PageMetadata < ActiveFedora::OmDatastream

  set_terminology do |t|
    t.root(path: "fields")
    t.number index_as: :stored_searchable, type: :integer
    t.text index_as: :stored_searchable

  end

  def self.xml_template
    Nokogiri::XML.parse("<fields/>")
  end

  def prefix
    '' # add a prefix for solr index terms if you need to namespace identical terms in multiple data streams 
  end

end
