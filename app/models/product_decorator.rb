Product.class_eval do
  
  # Create lambda scopes for each taxonomy (note : should be optimized ; right now it doesn't care if the taxon belongs in the taxonomy or not)
  Taxonomy.all.each do |t| 
    named_scope t.filter_name, lambda { |name| 
      joins("INNER JOIN products_taxons AS products_taxons_#{t.filter_name} ON (products.id = products_taxons_#{t.filter_name}.product_id) INNER JOIN taxons AS taxons_#{t.filter_name} ON (taxons_#{t.filter_name}.id = products_taxons_#{t.filter_name}.taxon_id)").where("taxons_#{t.filter_name}.name = ?", name)
    }
  end

end