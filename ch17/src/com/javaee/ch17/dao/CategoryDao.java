package com.javaee.ch17.dao;

import java.util.List;

import com.javaee.ch17.po.Category;
import com.javaee.ch17.vo.CategoryWithProductsCount;

public interface CategoryDao {

	public Category findCategoryById(int id);
	public List<Category> findCategories();
	public List<CategoryWithProductsCount> findCategoriesWithProdcutsCount();
	
	public int insertCategory(Category category);
	public int updateCategory(Category category);
	public int deleteCategory(int id);
}
