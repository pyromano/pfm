module OperationsHelper
  def categories_list
    current_user.categories.select(:id, :name).order(:name)
  end
end
