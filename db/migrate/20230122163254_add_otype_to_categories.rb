class AddMoneyFlowToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :money_flow, :integer
  end
end
