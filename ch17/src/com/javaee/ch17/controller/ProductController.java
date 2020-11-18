package com.javaee.ch17.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.javaee.ch17.po.Product;
import com.javaee.ch17.service.CategoryService;
import com.javaee.ch17.service.ProductService;

@Controller
public class ProductController {
	@Autowired
	private ProductService productService;
	
	@Autowired
	private CategoryService categoryService;
	
	@RequestMapping("findProducts")
	public String findProdcuts(HttpServletRequest request) {
		request.setAttribute("listProducts", productService.findProducts());
		return "findProducts";
	}
	@RequestMapping("toUpdateProduct")
	public String toUpdateProduct(HttpServletRequest request, int id) {
		return "forward:toOperateProduct?id="+id;
	}
	@RequestMapping("toOperateProduct")
	public String operateProduct(HttpServletRequest request, int id) { // Integer id 
		Product product=null; // 默认是当成添加。
		
		if(id>0) { // 是更新 (在转到目标视图之前 把这个id对应的Product各方面的字段值都读出来)
			product = productService.findProductById(id);
		}
		request.setAttribute("product", product);
		request.setAttribute("listCategories", categoryService.findCategories());// 得到所有类别信息
		return "toOperateProduct";  // 是提供更新、添加商品的界面
	}
	@RequestMapping("operateProduct")
	public String operateProduct(HttpServletRequest request, Product product) { //, String operateType 不需要这个参数，可根据product的id是否为零判断是添加还是更新。
		int theId = product.getId();
		String theMessage="";
		if(theId==0) { // 执行添加商品操作			
			//System.out.println("添加商品");
			if(product.getEntryTime()==null) {// 提交时未设置录入时间，则应填入当前时间
				product.setEntryTime(new Date());
			}			
			if(productService.insertProduct(product)==1) {
				theMessage = "商品添加成功！";
			} else {
				theMessage = "<script>alert('商品添加失败！');</script>";
			}
		} else { // 执行更新商品操作
			if(product.getModifyTime()==null) {// 提交时未设置修改时间，则应填入当前时间
				product.setModifyTime(new Date());
			}
			if(productService.updateProduct(product)==1) {
				theMessage = "商品更新成功！";
			} else {
				theMessage = "<script>alert('商品更新失败！');</script>";
			}			
		}
		request.setAttribute("theMessage", theMessage);
		return "forward:toOperateProduct?id="+theId;
		// return "forward:toOperateProduct?id=0"; // 添加后转向
		// return "forward:toOperateProduct?id="+product.getId(); 更新后转向		
	}	
	@RequestMapping("deleteProduct")
	public String deleteProduct(HttpServletRequest request, int id) {
		String theMessage="";
		if(productService.deleteProduct(id)==1) {
			theMessage="删除id为“"+id+"”的商品成功！";
		} else {
			theMessage="删除id为“"+id+"”的商品失败！";// 可能的原因：该id对应的商品已不存在。
		}
		request.setAttribute("theMessage", theMessage);
		return "forward:findProducts";
	}
}
