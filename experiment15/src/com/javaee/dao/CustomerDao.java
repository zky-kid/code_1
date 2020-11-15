package com.javaee.dao;
import java.util.HashMap;
import java.util.List;

import com.javaee.po.Customer;
import com.javaee.vo.CustomerRegisterValidVO;
import com.javaee.vo.FieldExistValidVO;
import com.javaee.vo.LoginVO;
/**
 * Customer接口文件
 */
public interface CustomerDao {

	public int getCustomersCount();
	// 查询客户信息
	public List<Customer> findCustomers();
	/**
	 * 根据id查询客户信息
	 */
	public Customer findCustomerById(int id); //Integer id 按教材这样写也可
	public Customer findCustomerByLogin(LoginVO loginVO);
	public Customer isExistSame(FieldExistValidVO fieldExistValidVO);
	public void addCustomer(Customer customer);
	
    /**
     * 分页操作，调用findByPage limit分页方法
     * @param map
     * @return
     */
	public List<Customer> findByPage(HashMap<String,Object> map);

	public void deleteCustomerById(int id); //删除一个会员
	public void deleteCustomers(List<Integer> ids); //删除多个会员
	
}
