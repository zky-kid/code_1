package com.javaee.ch17.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaee.ch17.dao.CustomerDao;
import com.javaee.ch17.po.Customer;
import com.javaee.ch17.service.CustomerService;
import com.javaee.ch17.utils.PageBean;
import com.javaee.ch17.vo.FieldExistValidVO;

@Service
// @Transactional  
//对数据库写时，要考虑用事务管理的话，就加这个注解 @Transactional。要注意加在类上和类中某个方法上的区别
public class CustomerServiceImpl implements CustomerService {

	//用注解形式实现注入CustomerDao，它的settr方法就可省
	@Autowired
	private CustomerDao customerDao;
	
	@Override
	public Customer findCustomerById(int id) { // Integer id		
		return customerDao.findCustomerById(id);
	}

	@Override
	public Customer findCustomerByUserName(String userName) {
		return customerDao.findCustomerByUserName(userName);
	}

	/*
	public List<Customer> findByPage(HashMap<String,Object> map){
		return customerDao.findByPage(map);
	}
	 */
	public PageBean<Customer> findByPage(int currentPage, int pageSize){ // 当前页号 每页最大记录数
		HashMap<String,Object> map = new HashMap<String,Object>();
        PageBean<Customer> pageBean = new PageBean<Customer>();



        //每页显示的数据
        //int pageSize=2; // 固定，不太好。有的记录在不同情景模块中，每页允许显示的最大记录数很可能不同。
        pageBean.setPageSize(pageSize);

        //封装总记录数
        int totalCount = customerDao.getCustomersCount();
        pageBean.setTotalCount(totalCount);

        //封装总页数
        double tc = totalCount;
        Double num =Math.ceil(tc/pageSize);//向上取整  28/10 = 2.8 最终是3
        int totalPage = num.intValue();
        pageBean.setTotalPage(totalPage);
        
        //封装当前页数  (要注意对删除操作后又返回分页页面时对当前页currentPage的影响，即拉回最新的[1, totalPage]。这才是合法的。)
        if(currentPage<1)
        	currentPage=1;
        else if(currentPage > totalPage) {
        	currentPage=totalPage;
        }
        	
        pageBean.setCurrPage(currentPage);        
        

        map.put("start",(currentPage-1)*pageSize);
        map.put("size", pageBean.getPageSize());
        //封装每页显示的数据
        List<Customer> lists = customerDao.findByPage(map);
        pageBean.setLists(lists);

        return pageBean;
	}
	@Override
	public List<Customer> findSomeCustomers(Customer customer) {
		return customerDao.findSomeCustomers(customer);
	}

	public int getSameCount(FieldExistValidVO fieldExistValidVO) {
		return customerDao.getSameCount(fieldExistValidVO);
	}
	
	public int getOtherSameCount(FieldExistValidVO fieldExistValidVO) {
		return customerDao.getOtherSameCount(fieldExistValidVO);
	}
	
	public int insertCustomer(Customer customer) {
		return customerDao.insertCustomer(customer);
	}

	@Override
	public List<Customer> findCustomers() {
		return customerDao.findCustomers();
	}
	public int deleteCustomer(int id) {
		return customerDao.deleteCustomer(id);
	}
	public int updateCustomer(Customer customer) {
		return customerDao.updateCustomer(customer);
	} //更新一个会员
}
