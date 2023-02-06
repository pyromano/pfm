module OperationsHelper
  def categories_list
    Category.select(:id, :name).order(:name)
  end
end
