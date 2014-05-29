# -*- encoding : utf-8 -*-
require 'blacklight/catalog'

class CatalogController < ApplicationController

  include Blacklight::Catalog
  include Hydra::Controller::ControllerBehavior
  # These before_filters apply the hydra access controls
  #before_filter :enforce_show_permissions, :only=>:show
  # This applies appropriate access controls to all solr queries
  #CatalogController.solr_search_params_logic += [:add_access_controls_to_solr_params]
  # This filters out objects that you want to exclude from search results, like FileAssets
  CatalogController.solr_search_params_logic += [:exclude_unwanted_models]


  configure_blacklight do |config|
    
    config.default_solr_params = {
      :qf => 'title_roman_tesim title_arabic_tesim FirstPageId_tesim title_persian_tesim handle_tesim
       format_extent_tesim author_roman_tesim publisher_roman_tesim publisher_arabic_tesim
       place_arabic_tesim coverage_spatial_lcsh_tesim subject_lcsh_tesim',
      :qt => 'search',
      :rows => 10
    }

    # solr field configuration for search results/index views
    config.index.show_link = 'title_roman_tesim'
    config.index.record_display_type = 'has_model_ssim'

    # solr field configuration for document/show views
    config.show.html_title = 'title_roman_tesim'
    config.show.heading = 'title_roman_tesim'
    config.show.display_type = 'has_model_ssim'

    # solr fields that will be treated as facets by the blacklight application
    #   The ordering of the field names is the order of the display
    #
    # Setting a limit will trigger Blacklight's 'more' facet values link.
    # * If left unset, then all facet values returned by solr will be displayed.
    # * If set to an integer, then "f.somefield.facet.limit" will be added to
    # solr request, with actual solr request being +1 your configured limit --
    # you configure the number of items you actually want _tsimed_ in a page.
    # * If set to 'true', then no additional parameters will be sent to solr,
    # but any 'sniffed' request limit parameters will be used for paging, with
    # paging at requested limit -1. Can sniff from facet.limit or
    # f.specific_field.facet.limit solr request params. This 'true' config
    # can be used if you set limits in :default_solr_params, or as defaults
    # on the solr side in the request handler itself. Request handler defaults
    # sniffing requires solr requests to be made with "echoParams=all", for
    # app code to actually have it echo'd back to see it.
    #
    # :show may be set to false if you don't want the facet to be drawn in the
    # facet bar
   
    config.add_facet_field solr_name('subject_lcsh', :facetable), :label => 'Topic', :limit => 20
    config.add_facet_field solr_name('language', :facetable), :label => 'Language', :limit => true
   
    config.add_facet_field solr_name('author_roman', :facetable), :label => 'Author'
    config.add_facet_field solr_name('coverage_spatial_lcsh', :facetable), :label => 'Place'

    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.default_solr_params[:'facet.field'] = config.facet_fields.keys
    #use this instead if you don't want to query facets marked :show=>false
    #config.default_solr_params[:'facet.field'] = config.facet_fields.select{ |k, v| v[:show] != false}.keys


    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display
    config.add_index_field solr_name('title_roman', :stored_searchable, type: :string), :label => 'Title:'
    config.add_index_field solr_name('title_arabic', :stored_searchable, type: :string), :label => 'Arabic Title:'    
    config.add_index_field solr_name('author_roman', :stored_searchable, type: :string), :label => 'Author:'
    config.add_index_field solr_name('author_arabic', :stored_searchable, type: :string), :label => 'Author:'
    config.add_index_field solr_name('format_extent', :stored_searchable, type: :string), :label => 'Format:'
    config.add_index_field solr_name('coverage_spatial_lcsh', :stored_searchable, type: :string), :label => 'Place:'
    config.add_index_field solr_name('subject_lcsh', :stored_searchable, type: :string), :label => 'Subject:'
    config.add_index_field solr_name('publisher', :stored_searchable, type: :string), :label => 'Publisher:'
    config.add_index_field solr_name('publisher_arabic', :stored_searchable, type: :string), :label => 'Publisher'
    config.add_index_field solr_name('handle', :stored_searchable, type: :string), :label => 'Handle:'
    config.add_index_field solr_name('identifier', :stored_searchable, type: :string), :label => 'Identifier:'
    config.add_index_field solr_name('FirstPageId', :stored_searchable, type: :string), :label =>'', :helper_method => 'render_image_from_url'

    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display
    config.add_show_field solr_name('title_roman', :stored_searchable, type: :string), :label => 'Title:'
    config.add_show_field solr_name('title_arabic', :stored_searchable, type: :string), :label => 'Arabic Title:'
    config.add_show_field solr_name('author_roman', :stored_searchable, type: :string), :label => 'Author:'
    config.add_show_field solr_name('author_arabic', :stored_searchable, type: :string), :label => 'Author'
    config.add_show_field solr_name('format_extent', :stored_searchable, type: :string), :label => 'Format:'
    config.add_show_field solr_name('coverage_spatial_lcsh', :stored_searchable, type: :string), :label => 'Place:'
    config.add_show_field solr_name('subject_lcsh', :stored_searchable, type: :text), :label => 'Subject:'
    config.add_show_field solr_name('publisher', :stored_searchable, type: :string), :label => 'Publisher:'
    config.add_show_field solr_name('publisher_arabic', :stored_searchable, type: :string), :label => 'Publisher'
    config.add_show_field solr_name('handle', :stored_searchable, type: :string), :label => 'Handle:'
    config.add_show_field solr_name('identifier', :stored_searchable, type: :string), :label => 'Identifier:'
    config.add_show_field solr_name('FirstPageId', :stored_searchable, type: :string), :label => '', :helper_method => 'render_image_from_url'
    


    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    #
    # Search fields will inherit the :qt solr request handler from
    # config[:default_solr_parameters], OR can specify a different one
    # with a :qt key/value. Below examples inherit, except for subject
    # that specifies the same :qt as default for our own internal
    # testing purposes.
    #
    # The :key is what will be used to identify this BL search field internally,
    # as well as in URLs -- so changing it after deployment may break bookmarked
    # urls.  A display label will be automatically calculated from the :key,
    # or can be specified manually to be different.

    # This one uses all the defaults set by the solr request handler. Which
    # solr request handler? The one set in config[:default_solr_parameters][:qt],
    # since we aren't specifying it otherwise.

    config.add_search_field 'all_fields', :label => 'All Fields'


    # Now we see how to over-ride Solr request handler defaults, in this
    # case for a BL "search field", which is really a dismax aggregate
    # of Solr search fields.

    config.add_search_field('title_roman') do |field|
      # :solr_local_parameters will be sent using Solr LocalParams
      # syntax, as eg {! qf=$title_qf }. This is neccesary to use
      # Solr parameter de-referencing like $title_qf.
      # See: http://wiki.apache.org/solr/LocalParams
      field.solr_local_parameters = {
        :qf => '$title_roman_qf',
        :pf => '$title_roman_pf'
      }
    end

    config.add_search_field('author') do |field|
      field.solr_local_parameters = {
        :qf => '$author_qf',
        :pf => '$author_pf'
      }
    end

    config.add_search_field('title_arabic') do |field|
      field.solr_local_parameters = {
        :qf => '$title_arabic_qf',
        :pf => '$title_arabic_pf'
      }
    end

    # Specifying a :qt only to show it's possible, and so our internal automated
    # tests can test it. In this case it's the same as
    # config[:default_solr_parameters][:qt], so isn't actually neccesary.
    config.add_search_field('subject') do |field|
      field.qt = 'search'
      field.solr_local_parameters = {
        :qf => '$subject_qf',
        :pf => '$subject_pf'
      }
    end

    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    config.add_sort_field 'score desc, pub_date_dtsi desc, title_tesi asc', :label => 'relevance'
    config.add_sort_field 'pub_date_dtsi desc, title_tesi asc', :label => 'year'
    config.add_sort_field 'author_tesi asc, title_tesi asc', :label => 'author'
    config.add_sort_field 'title_tesi asc, pub_date_dtsi desc', :label => 'title'

    # If there are more than this many search results, no spelling ("did you
    # mean") suggestion is offered.
    config.spell_max = 5
  end



end
