package com.javaee.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.javaee.service.AdministratorService;
import com.javaee.vo.AdminVO;

@Controller
@RequestMapping("/admin")
public class AdministratorController {
	@Autowired
	private AdministratorService administratorService;
	
	@RequestMapping("/showUpdateAdministratorPwd")
	public String showUpdateAdministratorPwd() {
		return "/admin/showUpdateAdministratorPwd";
	}
	
	@RequestMapping("/updateAdministratorPwd")
	public String updateAdministratorPwd(HttpServletRequest request, AdminVO adminVO) {
		if(administratorService.updateAdministratorPwd(adminVO)==1) {
			request.setAttribute("theMessage", "密码修改成功！");
			
		} else {
			request.setAttribute("theMessage", "<script>alert('账号、旧密码不正确！');</script>");
		}
		return "forward:/admin/showUpdateAdministratorPwd";
		
	}
}
