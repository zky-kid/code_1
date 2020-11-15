package com.javaee.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaee.dao.CustomerDao;
import com.javaee.dao.ProductDao;
import com.javaee.po.Customer;
import com.javaee.po.Product;
import com.javaee.service.ProductService;
import com.javaee.vo.NumbersResult;
import com.javaee.vo.ProductSearchVO;
import com.javaee.vo.ProductVO;

@Service
// @Transactional  
//对数据库写时，要考虑用事务管理的话，就加这个注解 @Transactional。要注意加在类上和类中某个方法上的区别
public class ProductServiceImpl implements ProductService {

	//用注解形式实现注入CustomerDao，它的setter方法就可省
	@Autowired
	private ProductDao productDao;

	
	@Override
	public int getProductsTotal() {
		return productDao.getProductsTotal();
	}


	@Override
	public void addProduct(Product product) {
		productDao.insertProduct(product);
		
	}


	@Override
	public Product findProductById(int id) { // Integer id		
		return productDao.findProductById(id);
	}

	public List<Product> findAllProducts(){
		return productDao.findAllProducts();
	}
	public List<Product> findProducts(ProductSearchVO productSearchVO){
		return productDao.findProducts(productSearchVO);
	}
	/*
	public int[] getMinAndMaxOfProductId() {
		return productDao.getMinAndMaxOfProductId();
	}
	*/
	public NumbersResult getMinAndMaxOfProductId() {
		return productDao.getMinAndMaxOfProductId();
	}
	
	public void updateProductById(Product product) {
		productDao.updateProductById(product);
	}
	public void updateProducts(List<Product> products) {
		productDao.updateProducts(products);
	}
	
	public void deleteProductById(int id) {
		productDao.deleteProductById(id);
	}
	public void deleteProducts(List<Integer> ids) {
		productDao.deleteProducts(ids);
		
	}
}
