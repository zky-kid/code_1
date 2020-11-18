package com.javaee.ch17.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaee.ch17.dao.ProductDao;
import com.javaee.ch17.po.Product;
import com.javaee.ch17.service.ProductService;
@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductDao productDao;
	
	@Override
	public Product findProductById(int id) {
		return productDao.findProductById(id);
	}

	@Override
	public List<Product> findProducts() {
		return productDao.findProducts();
	}

	@Override
	public int insertProduct(Product product) {
		return productDao.insertProduct(product);
	}

	@Override
	public int updateProduct(Product product) {
		return productDao.updateProduct(product);
	}

	@Override
	public int deleteProduct(int id) {
		return productDao.deleteProduct(id);
	}

}
