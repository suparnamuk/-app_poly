class CreateCategoriesSubCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories_sub_categories do |t|
      t.references :category, null: false, foreign_key: true
      t.references :sub_category, null: false, foreign_key: true
    end
  end
end
