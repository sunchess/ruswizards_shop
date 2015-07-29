ThinkingSphinx::Index.define 'product', :with => :active_record, :delta => true do
  indexes title
  indexes description
  # indexes category.title
end