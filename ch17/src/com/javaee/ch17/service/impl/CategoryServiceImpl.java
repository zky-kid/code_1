package com.javaee.ch17.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaee.ch17.dao.CategoryDao;
import com.javaee.ch17.po.Category;
import com.javaee.ch17.service.CategoryService;
import com.javaee.ch17.vo.CategoryWithProductsCount;
@Service
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	private CategoryDao categoryDao;
	
	@Override
	public Category findCategoryById(int id) {
		return categoryDao.findCategoryById(id);
	}

	@Override
	public List<Category> findCategories() {
		return categoryDao.findCategories();
	}
	
	public List<CategoryWithProductsCount> findCategoriesWithProdcutsCount(){
		return categoryDao.findCategoriesWithProdcutsCount();
	}

	@Override
	public int insertCategory(Category category) {
		return categoryDao.insertCategory(category);
	}

	@Override
	public int updateCategory(Category category) {
		return categoryDao.updateCategory(category);
	}

	@Override
	public int deleteCategory(int id) {
		return categoryDao.deleteCategory(id);
	}

}
