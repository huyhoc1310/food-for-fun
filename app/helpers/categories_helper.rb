module CategoriesHelper
  def find_category category_id
    @category = Category.find_by_id category_id
  end
end
