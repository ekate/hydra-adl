
class AdlBookMetadata < ActiveFedora::OmDatastream

    include OM::XML::Document
    include ActiveSupport

    set_terminology do |t|
      t.root(:path=>"mods", :xmlns=>"http://www.loc.gov/mods/v3", :schema=>"http://www.loc.gov/standards/mods/v3/mods-3-2.xsd", "xmlns:foo"=>"http://my.custom.namespace")

      t.handle(:index_as=>[:stored_searchable], :path=>"identifier", :attributes=>{:type=>"uri"})
      t.title_roman(:index_as=>[:stored_searchable], :path=>"titleInfo", :attributes=>{:script=>"Roman"})
      t.title_arabic(:index_as=>[:stored_searchable],:path=>"titleInfo", :attributes=>{:script=>"Arabic"})
      t.title_persian(:index_as=>[:stored_searchable],:path=>"titleInfo", :attributes=>{:script=>"Persian"})
      t.author_roman(:index_as=>[:stored_searchable], :path=>"namePart")
      t.author_arabic(:index_as=>[:stored_searchable], :path=>"namePart", :attribute=>{:script=>"Arabic"})
      t.publisher_roman(:index_as=>[:stored_searchable], :path=>"publisher", :attribute=>{:script=>"Roman"})
      t.format_extent(:index_as=>[:stored_searchable],:path=>"extent")
      t.publisher_arabic(:index_as=>[:stored_searchable], :path=>"publisher", :attribute=>{:script=>"Arabic"})
      t.date_issued_w3cdtf(:index_as=>[:stored_searchable], :path=>"dateIssued", :attribute=>{:encoding=>"w3cdtf"})
      t.date_arabic(:index_as=>[:stored_searchable], :path=>"dateIssued", :attribute=>{:script=>"Arabic"})
      t.description_abstract(:index_as=>[:stored_searchable], :path=>"abstract")
      t.identifier(:index_as=>[:stored_searchable], :path=>"identifier")
      t.place_roman(:index_as=>[:stored_searchable], :path=>"placeTerm")
      t.place_arabic(:index_as=>[:stored_searchable], :path=>"placeTerm")
      t.subject_lcsh(:index_as=>[:stored_searchable], :path=>"subject", :attributes=>{:authority=>"lcsh"})
      t.coverage_spatial_lcsh(:index_as=>[:stored_searchable], :path=>"geographic")
      t.identifier(:index_as=>[:stored_searchable], :path=>"identifier")
      
      t.language{
        t.lang_code(:index_as=>[:facetable], :path=>"languageTerm", :attributes=>{:type=>"code"})
      }
      
      t.subject_lcsh(:index_as=>[:facetable], :path=>"subject", :attributes=>{:authority=>"lcsh"})
      t.coverage_spatial_lcsh(:index_as=>[:facetable], :path=>"geographic")
      t.author_roman(:index_as=>[:facetable], :path=>"namePart", :attribute=>{:script=>"Roman"})

     
    end

    # Changes from OM::Properties implementation
    # renamed family_name => last_name
    # start_page & end_page now accessible as [:journal, :issue, :pages, :start] (etc.)
    
   def self.xml_template
    Nokogiri::XML.parse("<mods>")
  end

  def prefix
    # set a datastream prefix if you need to namespace terms that might occur in multiple data streams
    ""
  end

end
