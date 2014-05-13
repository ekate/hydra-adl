class Page < ActiveFedora::Base
  has_metadata 'descMetadata', type: Datastreams::PageMetadata

  belongs_to :book, :property=> :is_part_of

  has_attributes :number, datastream: 'descMetadata', multiple: false
  has_attributes :text, datastream: 'descMetadata', multiple: false

end
