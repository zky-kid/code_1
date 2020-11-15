package com.javaee.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaee.po.Customer;
import com.javaee.po.Product;
import com.javaee.service.CustomerService;
import com.javaee.utils.RandomValidateCode;
import com.javaee.vo.CustomerRegisterValidVO;
import com.javaee.vo.FieldExistValidVO;
import com.javaee.vo.ProductVO;

@Controller
public class CustomerController {
	
	@Autowired
	private CustomerService customerService;
	
	@ResponseBody
    @RequestMapping(value="/isExistSame", method=RequestMethod.POST)
    public Customer ajaxValidate(@RequestBody FieldExistValidVO fieldExistValidVO) {
        //System.out.println("JSON："+fieldExistValidVO.getFieldType()); // OK
		Customer customer = customerService.isExistSame(fieldExistValidVO);//从数据库查找前端出来的用户
        if(customer==null){//customer为空，说明没有找到该会员用户，可以注册。反之。
            //Message msg = new Message("yes");
            //return msg;//然后返回给前端执行success方法。
        }else{
            //Message msg = new Message("no");
            //return msg;
        } 
        return customer;
    }
    /**/
    /*
	public Customer ajaxValidate(HttpServletRequest request, @RequestBody String fieldValue, @RequestBody String fieldType) {
        //String userName = request.getParameter("username");
		FieldExistValidVO fieldExistValidVO = new FieldExistValidVO(fieldValue, fieldType);
        Customer customer = customerService.isExistSame(fieldExistValidVO);//从数据库查找前端出来的用户
        if(customer==null){//customer为空，说明没有找到该会员用户，可以注册。反之。
            //Message msg = new Message("yes");
            //return msg;//然后返回给前端执行success方法。
        }else{
            //Message msg = new Message("no");
            //return msg;
        } 
        return customer;
    }
    */
	/*
	 * 向注册页面跳转
	 */
	@RequestMapping("/toRegisterCustomer")
	public String toRegister() {
		return "registerCustomer";
	}
	@RequestMapping("/doRegisterCustomer")
	public String doRegister(HttpServletRequest request, Customer customer, String checkCode) {		
		HttpSession session = request.getSession();
		//System.out.println(request.getAttribute("checkCode")); 是null 所以要额外加个验证码的同名形式参数(由Spring MVC自动赋值)
		//System.out.println("验证码：" + checkCode); // OK		
		if(checkCode.equalsIgnoreCase((String)session.getAttribute(RandomValidateCode.RANDOMCODEKEY))) {
			customerService.addCustomer(customer);
			//System.out.println(customer);
			request.setAttribute("customer",customer); // jsp页面获取：${requestScope.customer}
			request.setAttribute("theMessage", "注册成功！");
			return "registerCustomer";			
		} else {
			request.setAttribute("theMessage", "<script>alert('输入的验证码不匹配！');</script>");
			return "registerCustomer";
		}

	}	
	/*
	客户信息 未分页
	*/
	/*
	@RequestMapping("/admin/findCustomers")
	public String findCustomers(HttpServletRequest request) {
		request.setAttribute("customersList", customerService.findCustomers());
		return "/admin/customers";
	}*/
	
	@RequestMapping("/admin/findCustomers")
	public String findCustomers(HttpServletRequest request, @RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage) {
		int pageSize=10;
		request.setAttribute("pageMsg", customerService.findByPage(currentPage, pageSize)); //回显分页数据

		return "/admin/customers";
	}	
	@RequestMapping("/admin/showACustomerById")
	public String showACustomerById(HttpServletRequest request, int id) {
		request.setAttribute("customer", customerService.findCustomerById(id));
		return "/admin/customer";
	}
	/*
	删除一个会员后回到分页视频时，应考虑当前页号的变化（应显示最贴近的那一页而不是机械地显示第一页）。
	@RequestMapping("/admin/deleteACustomerById")
	public String deleteAProductById(int id) {
		customerService.deleteCustomerById(id);;
		return "redirect:/admin/findCustomers";
	}
	*/
	@RequestMapping("/admin/deleteACustomerById")
	public String deleteAProductById(int id, int currentPage) {
		customerService.deleteCustomerById(id);
		return "redirect:/admin/findCustomers?currentPage="+currentPage;
	}
	
	@RequestMapping("/admin/editCustomers")
	public String editCustomers(String editType, int[] ids, int currentPage) { // editType 为del、upd时，表示批量删除、更新 也要考虑删除再回时当前页的影响
		if("del".equals(editType)) { // 批量删除
			//productService.deleteProducts(ids);
			List<Integer> customerIdsSelected=new ArrayList<Integer>();
			int temp;
			for(int theId: ids) {
				customerIdsSelected.add(theId);
			}
			customerService.deleteCustomers(customerIdsSelected);
		} 
		return "redirect:/admin/findCustomers?currentPage="+currentPage;
	}
}
