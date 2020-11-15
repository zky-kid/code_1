package com.javaee.service;

import java.util.List;

import com.javaee.po.Customer;
import com.javaee.utils.PageBean;
import com.javaee.vo.CustomerRegisterValidVO;
import com.javaee.vo.FieldExistValidVO;
import com.javaee.vo.LoginVO;

public interface CustomerService {

	public int getCustomersCount();
	public List<Customer> findCustomers();
	public Customer findCustomerById(int id);
	public Customer findCustomerByLogin(LoginVO loginVO);	
	public Customer isExistSame(FieldExistValidVO fieldExistValidVO);
	public void addCustomer(Customer customer);
	
	public PageBean<Customer> findByPage(int currentPage, int pageSize);//public PageBean<Customer> findByPage(int currentPage);
	
	public void deleteCustomerById(int id); //删除一个会员
	public void deleteCustomers(List<Integer> ids); //删除多个会员

}
