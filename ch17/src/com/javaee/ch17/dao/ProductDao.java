package com.javaee.ch17.dao;

import java.util.List;

import com.javaee.ch17.po.Product;

public interface ProductDao {

	public Product findProductById(int id);
	public List<Product> findProducts();
	public int insertProduct(Product product);
	public int updateProduct(Product product);
	public int deleteProduct(int id);
}
