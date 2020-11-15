package com.javaee.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.javaee.po.Product;
import com.javaee.service.ProductService;
import com.javaee.utils.MyUtils;
import com.javaee.utils.RandomValidateCode;
import com.javaee.vo.NumbersResult;
import com.javaee.vo.ProductSearchVO;
import com.javaee.vo.ProductVO;

@Controller
public class ProductController {
	@Autowired
	private ProductService productService;
	/**
	 * 添加商品
	 */
	@RequestMapping("/admin/toAddProduct")
	public String toAddProduct(HttpServletRequest request) {
		request.setAttribute("productsTotal", productService.getProductsTotal());
		return "/admin/addProduct";
	}	
	@RequestMapping("/admin/addProduct")
	public String addProduct(HttpServletRequest request, Product product, String checkCode) {
		HttpSession session = request.getSession();
		String theCheckCodeFromSession = (String) session.getAttribute(RandomValidateCode.RANDOMCODEKEY);
		if(checkCode.equalsIgnoreCase(theCheckCodeFromSession) ) {
			product.setEntryTime(new Date()); // 在Java程序中设置此条记录的录入时间(当数据表的日期时间字段因故未能设成数据库的datetime认值，就要在Java程序中指定)
			productService.addProduct(product);
			return "redirect:/admin/toAddProduct";
		} else {
			request.setAttribute("theMessage", "<script>alert('验证码错误！');</script>");
			return "forward:/admin/toAddProduct";			
		}

	}		
	/**
	 * 根据id查询商品详情
	 */
	@RequestMapping("toFindProduct")
	public String toFindProduct(HttpServletRequest request) {
		//int[] minAndMax = productService.getMinAndMaxOfProductId(); // 在jsp页中：${requestScope.minAndMax[0] }、${requestScope.minAndMax[1] }
		// 上面的在jsp中取值的方式是对的。但因MyBatis映射文件中select标签的parameterType=int 时，返回的可以是一个整型值(此时结果仅一条记录)或List<int>(此时结果是多条记录)
		// 保存不了一行时的两个int值，所以只能新定义一个VO类NumbersResult来封装这两个值(重点是：同时可容纳这两个值)。
		//如果select查到的结果集ResultSet有多行(每行都是两个int值)，则就是返回List<NumbersResult>而已。
		NumbersResult minAndMax = productService.getMinAndMaxOfProductId();
		request.setAttribute("minAndMax", minAndMax); // 在jsp页中：${requestScope.minAndMax.minIntV }、${requestScope.minAndMax.maxIntV }
		return "searchProductInfo";
	}
	@RequestMapping("/findProductById")
	public String findProductById(HttpServletRequest request, int id, String checkCode, Model model) {
		HttpSession session = request.getSession();
		String theCheckCodeFromSession = (String) session.getAttribute(RandomValidateCode.RANDOMCODEKEY);
		if(checkCode.equalsIgnoreCase(theCheckCodeFromSession) ) {
			Product product = productService.findProductById(id);
			model.addAttribute("product", product);
			//返回商品信息展示页面
			return "product";			
		} else {
			request.setAttribute("theMessage", "<script>alert('验证码错误！');</script>");
			//return "redirect:toFindProductById"; // 重定向后，这个request的值 就没有了 所以不能用重定向
			return "searchProductInfo";
		}
	}
	@RequestMapping("/findProducts")
	public String findProducts(HttpServletRequest request, String searchType, ProductSearchVO productSearchVO,  String checkCode) {
		//System.out.println("searchType:" + searchType + ";" + productSearchVO.getName() + ";" + MyUtils.getDateTimeString(productSearchVO.getEntryTimeBegin(), 1) );
		HttpSession session = request.getSession();
		String theCheckCodeFromSession = (String) session.getAttribute(RandomValidateCode.RANDOMCODEKEY);
		if(checkCode.equalsIgnoreCase(theCheckCodeFromSession) ) {			
			if("0".equals(searchType)) { // 精确查找
				Product productFromDB = productService.findProductById(productSearchVO.getId());
				request.setAttribute("product", productFromDB);
				//返回商品信息展示页面
				return "product";				
			} else { // 模糊查找  商品名称、价格区间
				request.setAttribute("productsList", productService.findProducts(productSearchVO));
				return "products";				
			}			
			
		} else {
			request.setAttribute("theMessage", "<script>alert('验证码错误！');</script>");
			//return "redirect:toFindProductById"; // 重定向后，这个request的值 就没有了 所以不能用重定向
			return "searchProductInfo";
		}		
		//return "product";
	}
	@RequestMapping("/showAProductById")
	public String showAProductById(HttpServletRequest request, int id) {
		Product product = productService.findProductById(id);
		request.setAttribute("product", product);
		return "product";
	}
	//@RequestMapping(value="/showAProductByIdForEdit", method={RequestMethod.GET, RequestMethod.POST})
	
	//@RequestMapping(value="/showAProductByIdForEdit", method=RequestMethod.GET)
	@RequestMapping(value="/admin/showAProductByIdForEdit")
	public String showAProductByIdForEdit(HttpServletRequest request, int id) {
		Product product = productService.findProductById(id);
		request.setAttribute("product", product);
		return "/admin/productForEdit";
	}	
	@RequestMapping("/admin/editProducts")
	public String editProducts(String editType, ProductVO productVO) { // editType 为del、upd时，表示批量删除、更新 
		//System.out.println("editType: "+editType); // OK		
		List<Product> products= productVO.getProducts();		
		//System.out.println("传入的个数：" + products.size()); // 竟然是所有的都提交过来了。
		
		
		if("del".equals(editType)) { // 批量删除
			//productService.deleteProducts(ids);
			List<Integer> productIdsSelected=new ArrayList<Integer>();
			int temp;
			for(Product theProduct: products) {
				temp = theProduct.getId();
				if(temp!=0) {
					productIdsSelected.add(temp);
					//System.out.println(theProduct.getId());					
				}
			}
			productService.deleteProducts(productIdsSelected);
		} else { // 批量修改
			List<Product> productsSelected=new ArrayList<Product>();
			for(Product theProduct: products) {
				if(theProduct.getId()!=0) {
					productsSelected.add(theProduct);
					System.out.println(theProduct.getId());
				}
			}
			System.out.println("处理后，选中个数：" + productsSelected.size()); 
			productService.updateProducts(productsSelected);
		}
		return "forward:/admin/findAllProducts";
	}
	@RequestMapping("/admin/findAllProducts")
	public String findAllProductsForAdministrator(HttpServletRequest request) {
		request.setAttribute("productsList", productService.findAllProducts());
		return "/admin/products";
	}
	@RequestMapping("/findAllProducts")
	public String findAllProducts(HttpServletRequest request) {
		request.setAttribute("productsList", productService.findAllProducts());
		return "products";
	}	
	@RequestMapping("/admin/deleteAProductById")
	public String deleteAProductById(int id) {
		productService.deleteProductById(id);
		return "redirect:/admin/findAllProducts";
	}
	@RequestMapping("/admin/updateAProductById")
	//@RequestMapping(value="updateAProductById", method= {RequestMethod.GET, RequestMethod.POST})
	public String updateAProductById(HttpServletRequest request, Product product) {
		productService.updateProductById(product);
		int theID = product.getId();
		/*
		// 失败：名称和价格都得到更新，但两个日期就丢了，变成null。但其实是有值的。
		product =null;
		product = productService.findProductById(theID);
		request.setAttribute("theMessage", "修改成功！");
		request.removeAttribute("product");
		request.setAttribute("product", product);
		//System.out.println(product.getModifyTime()); // OK 但页面的${product.modifyTime}取的就是空值
		return "productForEdit";
		*/
		
		request.setAttribute("theMessage", "修改成功！");
		return "redirect:/admin/showAProductByIdForEdit?id="+theID; // OK, 但request中设的东西，没了。
		//return "forward:/showAProductByIdForEdit?id="+theID; // Request method 'POST' not supported  请求行中接收的方法由源服务器知道，但目标资源不支持
		// 这句不行。  原因未知。失败！ 所以，暂时只能用redirect。此时可把theMessage存入session，然后在视图页中取出后立即将session中的这个量remove掉。
		/**/
	}	
	@RequestMapping("/admin/test")
	// http://localhost:8080/项目根/test 回车即可。但test/ 回车就不行。
	public String myTest() {
		return "forward:/showAProductByIdForEdit?id="+2; // OK 表明：forward: 请求串?参数1=值1&参数2=值2 这样的方式是可以的。
	}
}
