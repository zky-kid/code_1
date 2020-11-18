package com.javaee.ch17.dao;
import java.util.HashMap;
import java.util.List;

import com.javaee.ch17.po.Customer;
import com.javaee.ch17.vo.FieldExistValidVO;
/**
 * Customer接口文件
 */
public interface CustomerDao {
	/**
	 * 根据id查询客户信息
	 */
	public Customer findCustomerById(int id); //Integer id 按教材这样写也可  注：这种返回实体的方法，当结果集条数是零时，返回null。
	public Customer findCustomerByUserName(String userName);// 查询是否已有指定的用户名的会员
	public List<Customer> findCustomers(); // 查所有用户。
	public List<Customer> findByPage(HashMap<String,Object> map);// 考虑了分页
	public List<Customer> findSomeCustomers(Customer customer);// 模糊查询   注：这种返回List<实体>的方法，当结果集条数是零时，返回不是null，而仍是个含零个元素的List。
	public int getCustomersCount();
	public int getSameCount(FieldExistValidVO fieldExistValidVO); // 添加
	public int getOtherSameCount(FieldExistValidVO fieldExistValidVO);// 更新时需要查看当前输入的内容是否和别人重复
	public int insertCustomer(Customer customer);
	public int deleteCustomer(int id); // 删除指定id的会员
	public int updateCustomer(Customer customer); //更新一个会员
	
}
