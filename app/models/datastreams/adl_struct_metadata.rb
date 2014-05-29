class AdlStructMetadata < ActiveFedora::OmDatastream

    include OM::XML::Document
    include ActiveSupport

    set_terminology do |t|
      t.root(:path=>"fields")
      t.FirstPageId(:index_as=>[:stored_searchable], :path=>"FirstPageId" )
      t.format_extent_imageCount(:index_as=>[:stored_searchable], :path=>"format_extent_imageCount" )
    end

    # Changes from OM::Properties implementation
    # renamed family_name => last_name
    # start_page & end_page now accessible as [:journal, :issue, :pages, :start] (etc.)

   def self.xml_template
    Nokogiri::XML.parse("<fields>")
  end

  def prefix
    # set a datastream prefix if you need to namespace terms that might occur in multiple data streams
    ""
  end

end

