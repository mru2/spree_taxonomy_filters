Product.class_eval do
  
  # Create lambda scopes for each taxonomy (note : should be optimized ; right now it doesn't care if the taxon belongs in the taxonomy or not)
  Taxonomy.all.each do |t| 
    named_scope t.filter_name, lambda { |name| joins(:taxons).where("taxons.name = ?", name) }
  end

end