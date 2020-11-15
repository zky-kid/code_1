package com.javaee.dao;

import java.util.List;

import com.javaee.po.Product;
import com.javaee.vo.NumbersResult;
import com.javaee.vo.ProductSearchVO;
import com.javaee.vo.ProductVO;

public interface ProductDao {
	public void insertProduct(Product product); // 添加商品
	public Product findProductById(int id); // 通过id找到商品的信息
	public int getProductsTotal(); // 得到现有商品的总记录数
	public List<Product> findAllProducts(); // 查所有商品信息
	public List<Product> findProducts(ProductSearchVO productSearchVO); //模糊查询商品信息
	public NumbersResult getMinAndMaxOfProductId();//public int[] getMinAndMaxOfProductId(); // 得到产品编号的最小值和最大值
	
	public void updateProductById(Product product); // 修改一个商品
	public void updateProducts(List<Product> products); // 修改多个商品
	
	public void deleteProductById(int id); //删除一个商品
	public void deleteProducts(List<Integer> ids); //删除多个商品  public void deleteProducts(int[] ids); 发现用List方便获取
}
