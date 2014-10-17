require 'blacklight'
require 'leaflet-rails'
require 'leaflet-markercluster-rails'
require 'leaflet-sidebar-rails'

module Blacklight
  module Maps
    class Engine < Rails::Engine
      # Set some default configurations
      Blacklight::Configuration.default_values[:view].maps.geojson_field = 'geojson'
      Blacklight::Configuration.default_values[:view].maps.placename_property = 'placename'
      Blacklight::Configuration.default_values[:view].maps.coordinates_field = 'coordinates'
      Blacklight::Configuration.default_values[:view].maps.search_mode = 'geo_facet'
      Blacklight::Configuration.default_values[:view].maps.geo_facet_field = 'geo_facet'
      Blacklight::Configuration.default_values[:view].maps.tileurl = "http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
      Blacklight::Configuration.default_values[:view].maps.mapattribution = 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>'
      Blacklight::Configuration.default_values[:view].maps.maxzoom = 8

      # Add our helpers
      initializer 'blacklight-maps.helpers' do |app|
        ActionView::Base.send :include, BlacklightMapsHelper
      end

      # This makes our rake tasks visible.
      rake_tasks do
        Dir.chdir(File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))) do
          Dir.glob(File.join('railties', '*.rake')).each do |railtie|
            load railtie
          end
        end
      end
    end
  end
end
