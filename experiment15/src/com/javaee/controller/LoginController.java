package com.javaee.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.javaee.po.Administrator;
import com.javaee.po.Customer;
import com.javaee.service.AdministratorService;
import com.javaee.service.CustomerService;
import com.javaee.utils.MyUtils;
import com.javaee.utils.RandomValidateCode;
import com.javaee.vo.LoginVO;

@Controller
public class LoginController {

	@Autowired
	private AdministratorService administratorService;
	@Autowired
	private CustomerService customerService;// 注：注解@Autowired对下下条的属性无效。因此，要再写一次才能让customerService有效。
	
	@RequestMapping("/login")
	public String toLogin(HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		session.invalidate();
		return "login";
	}
	@RequestMapping("/admin/loginOut")
	public String loginOutForAdministrator(HttpServletRequest request) {
		HttpSession session = request.getSession();	
		session.removeAttribute(MyUtils.ADMINISTRATOR_SESSION);// session.removeAttribute("administrator"); 改用常量避免到处出现"administrator"这个键值，方便修改
		session.invalidate();
		return "login";
	}
	@RequestMapping("/customer/loginOut")
	public String loginOutForCustomer(HttpServletRequest request) {
		HttpSession session = request.getSession();	
		session.removeAttribute(MyUtils.CUSTOMER_SESSION);//和上面不直接用"administrator"原因相同
		session.invalidate();
		return "login";
	}	
	@RequestMapping("/admin/adminMain")
	public String toAdminIndex() {
		return "/admin/adminIndex";
	}
	@RequestMapping("/customer/customerMain")
	public String toCustomerIndex() {
		return "/customer/customerIndex";
	}	
	@RequestMapping("/doLogin")
	public String doLogin(HttpServletRequest request, LoginVO loginVO, String checkCode) {
		HttpSession session = request.getSession();		
		String theCheckCodeFromSession = (String)session.getAttribute(RandomValidateCode.RANDOMCODEKEY);
		if(theCheckCodeFromSession.equalsIgnoreCase(checkCode)) {
			if("0".equals(loginVO.getLoginRole())) { // 管理员 应到t_admin表中核对
				Administrator administrator = administratorService.findAdministratorByLogin(loginVO);
				if(null !=administrator) {// 通过封装在loginVO内的账号、密码在t_admin表中找到这样的一条记录，表明 账号、密码正确。
					session.setAttribute(MyUtils.ADMINISTRATOR_SESSION, administrator);//session.setAttribute("administrator", administrator);
					return "forward:/admin/adminMain"; // 转到管理员首页
				} else {
					request.setAttribute("theMessage", "<script>alert('管理员的账号、密码错误！');</script>");
					return "login";
				}				
			} else { // 不是管理员的其他角色。 比如是会员，此时应到Customer表中核对
				Customer customer = customerService.findCustomerByLogin(loginVO);
				if(null !=customer) {
					session.setAttribute(MyUtils.CUSTOMER_SESSION, customer);//session.setAttribute("customer", customer);
					return "forward:/customer/customerMain"; // 转到角色首页
				} else {
					request.setAttribute("theMessage", "<script>alert('会员的账号、密码错误！');</script>");
					return "login";
				}
			}
		} else {
			request.setAttribute("theMessage", "<script>alert('验证码输入错误！');</script>");
			return "login";
		}		
	}	
}
