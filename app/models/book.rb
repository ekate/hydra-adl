
class Book < ActiveFedora::Base
  has_metadata 'descMetadata', type: AdlBookMetadata
  has_metadata 'structMetadata', type:  AdlStructMetadata
 
  has_attributes :title_roman, datastream: 'descMetadata', multiple: true
  has_attributes :title_arabic, datastream: 'descMetadata', multiple: true
  has_attributes :title_persian, datastream: 'descMetadata', multiple: true
  has_attributes :handle, datastream: 'descMetadata', multiple: false
  has_attributes :identifier, datastream: 'descMetadata', multiple: false


      has_attributes :"handle", datastream: 'descMetadata', multiple: true
     
      has_attributes :"format_extent_imageCount",datastream: 'structMetadata', multiple: false
      has_attributes :"format_extent", datastream: 'descMetadata', multiple: false
      has_attributes :"FirstPageId", datastream: 'structMetadata',  multiple: false
     
      has_attributes :"author_roman", datastream: 'descMetadata', multiple: true
      has_attributes :"publisher_roman", datastream: 'descMetadata', multiple: true
      has_attributes :"publisher_arabic", datastream: 'descMetadata', multiple: true
      has_attributes :"place_roman", datastream: 'descMetadata', multiple: true
      has_attributes :"place_arabic", datastream: 'descMetadata', multiple: true
      has_attributes :"date_issued_w3cdtf", datastream: 'descMetadata', multiple: true
      has_attributes :"date_arabic", datastream: 'descMetadata', multiple: true
      has_attributes :"description_abstract", datastream: 'descMetadata', multiple: true
      has_attributes :"subject_lcsh", datastream: 'descMetadata', multiple: true
      has_attributes :"coverage_spatial_lcsh", datastream: 'descMetadata', multiple: true

end
