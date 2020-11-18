package com.javaee.ch17.service;

import java.util.List;

import com.javaee.ch17.po.Category;
import com.javaee.ch17.vo.CategoryWithProductsCount;

public interface CategoryService {
	public Category findCategoryById(int id);
	public List<Category> findCategories();
	public List<CategoryWithProductsCount> findCategoriesWithProdcutsCount();
	
	public int insertCategory(Category category);
	public int updateCategory(Category category);
	public int deleteCategory(int id);
}
