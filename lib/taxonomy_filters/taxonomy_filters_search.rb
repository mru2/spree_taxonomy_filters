require 'spree/search/base'

module Spree::Search
  class TaxonomyFilter < Base
    
    def initialize(params)
      super
      # Add the filters to the searcher properties
      @properties[:filters] = find_filters(params)
    end

    # Apply the filters
    def get_base_scope
      base_scope = super
      # Each pair has the scope name as a key, and the scope argument as a value
      @properties[:filters].each_pair do |k,v|
        base_scope = base_scope.send(k,v)
      end
      base_scope
    end
    
    private
    
    def find_filters(params)
      scopes = {}
      # Iterate through the params ; find the one whose key begins with 'by_' and is a Product method
      params.each_pair do |k,v|
        if (k[0,3] == "by_") && (Product.respond_to? k)
          scopes[k] = v
        end
      end
      scopes
    end


  end
end