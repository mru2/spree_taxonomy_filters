ProductsController.class_eval do
  
  Taxonomy.all.each do |t|
    has_scope t.filter_name
  end
      
end