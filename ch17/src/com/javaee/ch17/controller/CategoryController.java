package com.javaee.ch17.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.javaee.ch17.po.Category;
import com.javaee.ch17.service.CategoryService;

@Controller
public class CategoryController {
	@Autowired
	private CategoryService categoryService;
	
	/*
	@RequestMapping("findCategories")
	public String findCategories(HttpServletRequest request) {
		request.setAttribute("listCategories", categoryService.findCategories());
		return "findCategories";
	}
	// 这个未考虑有商品时的类别删了后对商品的影响
	*/
	@RequestMapping("findCategories")
	public String findCategories(HttpServletRequest request) {
		request.setAttribute("listCategoriesWithProductsCount", categoryService.findCategoriesWithProdcutsCount());
		return "findCategories";
	}	
	// 将修改、添加类别的两个功能合成一个请求
	@RequestMapping("operateCategory")
	public String operateCategory(HttpServletRequest request, Category category, String operateType) { // operateType 有2种值：i、u分别表示添加、更新
		String theMessage="";
		if("i".equals(operateType)) { // 是增加类别
			if(categoryService.insertCategory(category)==1) {
				theMessage = "类别添加成功！";//request.setAttribute("theMessage", "类别添加成功！");
			} else {
				theMessage = "<script>alert('类别添加失败！');</script>"; // 概率很低，可能原因：违背约束、读写异常
			}
		} else { // 是修改类别
			if(categoryService.updateCategory(category)==1) {
				theMessage = "类别修改成功！";
			} else {
				theMessage = "<script>alert('类别修改失败！');</script>";
			}
		}
		request.setAttribute("theMessage", theMessage);
		return "forward:findCategories";
	}
	@RequestMapping("deleteCategory")
	public String deleteCategory(HttpServletRequest request, int id) {
		String theMessage="";
		if(categoryService.deleteCategory(id)==1) {
			theMessage = "类别删除成功！";
		} else {
			theMessage = "<script>alert('类别删除失败！');</script>";
		}
		request.setAttribute("theMessage", theMessage);
		return "forward:findCategories";
		
	}
}
