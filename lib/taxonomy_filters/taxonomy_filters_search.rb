require 'spree/search/base'

module Spree::Search
  class TaxonomyFilter < Base
    
    def initialize(params)
      super
      # Add the scopes to the searcher properties
      @properties[:scopes] = find_scopes(params)
    end

    # Apply the scopes
    def get_base_scope

      # Get the base scopes
      base_scope = super
      # Add the scopes who were in the params
      @properties[:scopes].each_pair do |scope_name,scope_value|
        base_scope = base_scope.send(scope_name,scope_value)
      end
      base_scope
    end
    
    private
    
    # Find the scopes in the params
    def find_scopes(params)
      scopes = {}
      # Iterate through the params ; find the ones who are scopes (i.e : Product respond to it, and the result is an ActiveRecord::Relation)
      params.each_pair do |scope_name,scope_value|
        if (Product.respond_to? scope_name)
          if (Product.where('0').send(scope_name,scope_value).class == ActiveRecord::Relation)
            scopes[scope_name] = scope_value
          end
        end
      end
      scopes
    end


  end
end