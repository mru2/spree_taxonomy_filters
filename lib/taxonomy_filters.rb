require 'spree_core'
require 'has_scope'
require 'taxonomy_filters_hooks'

module TaxonomyFilters
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      
      # Put here because loading trouble otherwise...
      Taxonomy.class_eval do
        def filter_name
          "by_#{self.name.underscore}".to_sym
        end
      end      
      
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
