package com.javaee.ch17.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaee.ch17.po.Card;
import com.javaee.ch17.po.Customer;
import com.javaee.ch17.service.CardService;
import com.javaee.ch17.service.CustomerService;
import com.javaee.ch17.utils.RandomValidateCode;
import com.javaee.ch17.vo.FieldExistValidVO;


@Controller
public class CustomerController {
	@Autowired
	private CustomerService customerService;

	@Autowired
	private CardService cardService;
	/**
	 * 根据id查询客户详情 toFindCustomerById
	 */
	@RequestMapping("toFindCustomerByIdOrSomeCustomers")
	public String toFindCustomerById() {
		return "findCustomerInfo";
	}
	/*
	@RequestMapping("/findCustomerById")
	public String findCustomerById(HttpServletRequest request, int id, String checkCode, Model model) {
		HttpSession session = request.getSession();
		String theCheckCodeFromSession = (String) session.getAttribute(RandomValidateCode.RANDOMCODEKEY);
		if(checkCode.equalsIgnoreCase(theCheckCodeFromSession) ) {
			Customer customer = customerService.findCustomerById(id);
			model.addAttribute("customer", customer);
			//返回客户信息展示页面
			return "customer";			
		} else {
			request.setAttribute("theMessage", "<script>alert('验证码错误！');</script>");
			//return "redirect:toFindCustomerById"; // 重定向后，这个request的值 就没有了 所以不能用重定向
			return "findCustomerInfo";
		}
	}
	*/
	@RequestMapping("/findCustomerByIdOrSomeCustomers")
	public String findCustomerByIdOrSomeCustomers(HttpServletRequest request, Customer customer, String checkCode) {
		HttpSession session = request.getSession();
		String theCheckCodeFromSession = (String) session.getAttribute(RandomValidateCode.RANDOMCODEKEY);
		if(checkCode.equalsIgnoreCase(theCheckCodeFromSession) ) {
			int id = customer.getId();
			System.out.println("id是"+id);
			if(id!=0) {// 用户在查询表单中输入了id，表示是精确查询
				request.setAttribute("customerX", customerService.findCustomerById(id));// 注：当记录条数是零时，返回null。这和返回List类型是不同的。
				return "customer";	
			} else {// 提交时，id输入框中无值，表示是模糊查询 （userName userRealName email contactPhone address）
				request.setAttribute("listCustomers", customerService.findSomeCustomers(customer));//注：当记录条数是零时，并不是返回null。仍是返回List只不过里面无元素。
				return "customers";
			}			
			//返回客户信息展示页面					
		} else {
			request.setAttribute("theMessage", "<script>alert('验证码错误！');</script>");
			//return "redirect:toFindCustomerById"; // 重定向后，这个request的值 就没有了 所以不能用重定向
			return "findCustomerInfo";
		}
	}	
	@RequestMapping("/customerDetail")
	public String customerDetail(HttpServletRequest request, int id) {
		//Customer customer = customerService.findCustomerById(id);
		request.setAttribute("customerX", customerService.findCustomerById(id));
		return "customer";
	}

	@ResponseBody
    @RequestMapping("/isExistSame") // @RequestMapping(value="/isExistSame", method=RequestMethod.POST)
    public boolean ajaxValidate(@RequestBody FieldExistValidVO fieldExistValidVO) {
        return customerService.getSameCount(fieldExistValidVO)==1? true:false;
    }

	@ResponseBody
    @RequestMapping("/isOtherExistSame") // @RequestMapping(value="/isExistSame", method=RequestMethod.POST)
    public boolean ajaxValidateOhter(@RequestBody FieldExistValidVO fieldExistValidVO) {
        return customerService.getOtherSameCount(fieldExistValidVO)==1? true:false;
    }
	// 设置两个请求：第一个请求，转向一个提供添加会员表单的jsp视图
	@RequestMapping("toInsertCustomer")
	public String toInsertCustomer() {
		return "insertCustomer";		
	}
	// 第二个请求：添加表单按了提交后，通知service层 dao层执行insert操作。
	@RequestMapping("doInsertCustomer")
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.DEFAULT, readOnly = false)
	public String doInsertCustomer(HttpServletRequest request, Customer customer, String checkCode) {
		// 先要验证输入的验证码和后台存有的验证码是否一致
		if(!checkCode.equalsIgnoreCase((String)request.getSession().getAttribute(RandomValidateCode.RANDOMCODEKEY))) {
			request.setAttribute("theMessage", "<script>alert('验证码错误！');</script>");
			return "insertCustomer";
		}
		if(customerService.findCustomerByUserName(customer.getUserName())!=null){ // 已有这样的用户名的会员，不能做添加
			request.setAttribute("theMessage", "<script>alert('换别的用户名以继续添加！');</script>");
			//return "insertCustomer";
		} else { // 用户名是新的，可以添加
			Card theCard = customer.getCard(); // 此时theCard对象，主键id是空的。
			cardService.insertCard(theCard); // 先将卡信息添加进card表中，并返回该行对应的id用作Customer表的cardId列的值
			customer.setCard(theCard);
			int rows = customerService.insertCustomer(customer); // 前提是要保证这个customer添加后，不能违背数据库的完整性。
			if(rows == 1) {
				request.setAttribute("theMessage", "添加会员成功！");
				//return "insertCustomer";
			} else {
				request.setAttribute("theMessage", "<script>alert('添加会员出错！');</script>");
				//return "insertCustomer";				
			}
		}		
		return "insertCustomer";
	}
	
	@RequestMapping("findCustomers0")
	public String findCustomers(HttpServletRequest request) {
		/*
		List<Customer> listCustomers = customerService.findAllCustomers();
		request.setAttribute("listCustomers", listCustomers);
		*/
		request.setAttribute("listCustomers", customerService.findCustomers());
		return "customers";
	}
	@RequestMapping("findCustomers")
	public String findCustomers(HttpServletRequest request, @RequestParam(value="currentPage",defaultValue="1",required=false) int currentPage) {
		int pageSize=5;
		request.setAttribute("pageMsg", customerService.findByPage(currentPage, pageSize)); //回显分页数据

		return "customers";
	}	
	@RequestMapping("toUpdateCustomer")
	public String toUpdateCustomer(HttpServletRequest request) {
		String idStr=request.getParameter("id");		
		try {
			if(null!=idStr && !"".equals(idStr)) {
				int id= Integer.parseInt(idStr);
				Customer customer =customerService.findCustomerById(id);
				request.setAttribute("customer", customer);
				return "updateCustomer";
			} else {
				//request.setAttribute("theMessage", "<script>alert('参数出错！');history.go(-1);</script>");	
				request.setAttribute("theMessage", "<script>alert('参数出错！');</script>");	
				
			}			
		} catch (Exception e) {
			request.setAttribute("theMessage", "<script>alert('参数出错！');history.go(-1);</script>");	
		}
		return "forward:findCustomers";
	}
	/*
	public String toUpdateCustomer(int id, HttpServletRequest request) {
		try {
			Customer customer =customerService.findCustomerById(id);
			request.setAttribute("customer", customer);			
		} catch (Exception e) {
			request.setAttribute("theMessage", "<script>alert('参数出错！');history.go(-1);</script>");	
		}
		return "updateCustomer";
	}
	public String toUpdateCustomer(int id, HttpServletRequest request) {
		Customer customer =customerService.findCustomerById(id);
		request.setAttribute("customer", customer);
		return "updateCustomer";
	}	 
	*/
	@RequestMapping("deleteCustomer")
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.DEFAULT, readOnly = false)
	public String deleteCustomer(int id) { // 涉及到Customer、Card两张表。
		/*
		customerService.deleteCustomer(id);
		*/
		// 在删除会员之前，要先得到该会员对应的证件识别号cardId，然后到customer表删除该会员记录，最后到card表中删该卡对应记录。
		int theCardId = customerService.findCustomerById(id).getCard().getId();// 找出欲删除的会员的cardId的值
		
		
		customerService.deleteCustomer(id);
		cardService.deleteCard(theCardId);


		return "redirect:findCustomers";
		//return "customers";  // 没有机会在request作用域中添加键值为listCustomers的对象。
		
	}
	@RequestMapping("doUpdateCustomer")
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.DEFAULT, readOnly = false)
	public String doUpdateCustomer(HttpServletRequest request, Customer customer, String checkCode) {
		// 先要验证输入的验证码和后台存有的验证码是否一致
		if(!checkCode.equalsIgnoreCase((String)request.getSession().getAttribute(RandomValidateCode.RANDOMCODEKEY))) {
			request.setAttribute("theMessage", "<script>alert('验证码错误！');</script>");
			
		} else {
			// 要更新Customer表、Card表
			if(cardService.updateCard(customer.getCard())==1 && customerService.updateCustomer(customer)==1) {
				request.setAttribute("theMessage", "更新会员成功！");				
			} else {
				request.setAttribute("theMessage", "<script>alert('更新会员出错！');</script>");
			}			
		}		
		return "forward:toUpdateCustomer?id="+customer.getId();
	}	
	@RequestMapping("testSubmitWithCKEditor")
	public String testSubmitWithCKEditor(String editor) {
		System.out.println(editor);
		return null;
	}
}
