package com.javaee.ch17.service;

import java.util.HashMap;
import java.util.List;

import com.javaee.ch17.po.Customer;
import com.javaee.ch17.utils.PageBean;
import com.javaee.ch17.vo.FieldExistValidVO;


public interface CustomerService {
	/**
	 * 根据id查询客户信息   这个和Dao层的CustomerDao类似
	 */
	public Customer findCustomerById(int id); //Integer id 按教材这样写，也可。注：这种返回实体的方法，当结果集条数是零时，返回null。
	public Customer findCustomerByUserName(String userName);
	public List<Customer> findCustomers();
	public PageBean<Customer> findByPage(int currentPage, int pageSize);//public List<Customer> findByPage(HashMap<String,Object> map);
	public List<Customer> findSomeCustomers(Customer customer);// 模糊查询 注：这种返回List<实体>的方法，当结果集条数是零时，返回不是null，而仍是个含零个元素的List。
	public int getSameCount(FieldExistValidVO fieldExistValidVO);
	public int getOtherSameCount(FieldExistValidVO fieldExistValidVO);
	public int insertCustomer(Customer customer);
	public int deleteCustomer(int id); // 删除指定id的会员
	public int updateCustomer(Customer customer); //更新一个会员	
}
