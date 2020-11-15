package com.javaee.service;

import java.util.List;

import com.javaee.po.Product;
import com.javaee.vo.NumbersResult;
import com.javaee.vo.ProductSearchVO;
import com.javaee.vo.ProductVO;

public interface ProductService {

	public int getProductsTotal(); // 得到商品的总记录数 
	public void addProduct(Product product); // 添加商品信息
	/**
	 * 根据id查询商品信息   这个和Dao层的ProductDao类似
	 */
	public Product findProductById(int id); //Integer id 按教材这样写，也可。
	public List<Product> findAllProducts(); // 查所有商品信息
	public List<Product> findProducts(ProductSearchVO productSearchVO); // 模糊查询商品信息
	public NumbersResult getMinAndMaxOfProductId();//public int[] getMinAndMaxOfProductId();
	
	public void updateProductById(Product product);
	public void updateProducts(List<Product> products); // 修改多个商品
	
	public void deleteProductById(int id); //删除一个商品
	public void deleteProducts(List<Integer> ids); //删除多个商品 public void deleteProducts(int[] ids);
}
 