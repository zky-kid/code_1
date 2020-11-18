package com.javaee.ch17.service;

import java.util.List;

import com.javaee.ch17.po.Product;

public interface ProductService {
	public Product findProductById(int id);
	public List<Product> findProducts();
	public int insertProduct(Product product);
	public int updateProduct(Product product);
	public int deleteProduct(int id);
}
