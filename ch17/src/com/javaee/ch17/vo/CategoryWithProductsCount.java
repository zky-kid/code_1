package com.javaee.ch17.vo;

import java.io.Serializable;

import com.javaee.ch17.po.Category;

public class CategoryWithProductsCount implements Serializable {// 封装一个类别及其商品种类数

	private static final long serialVersionUID = 1L;
	
	private Category category;
	private int productsCount;
	
	public Category getCategory() {
		return category;
	}
	public void setCategory(Category category) {
		this.category = category;
	}
	public int getProductsCount() {
		return productsCount;
	}
	public void setProductsCount(int productsCount) {
		this.productsCount = productsCount;
	}
	
	
}
