package com.javaee.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaee.dao.CustomerDao;
import com.javaee.po.Customer;
import com.javaee.service.CustomerService;
import com.javaee.utils.PageBean;
import com.javaee.vo.CustomerRegisterValidVO;
import com.javaee.vo.FieldExistValidVO;
import com.javaee.vo.LoginVO;

@Service
public class CustomerServiceImpl implements CustomerService {

	@Autowired
	private CustomerDao customerDao;

	public List<Customer> findCustomers(){
		return customerDao.findCustomers();
	}
	public int getCustomersCount() {
		return customerDao.getCustomersCount();
	}
	@Override
	public Customer findCustomerById(int id) {
		
		return customerDao.findCustomerById(id);
	}

	@Override
	public Customer findCustomerByLogin(LoginVO loginVO) {
		return customerDao.findCustomerByLogin(loginVO);
	}

	@Override
	public Customer isExistSame(FieldExistValidVO fieldExistValidVO) {
		return customerDao.isExistSame(fieldExistValidVO);
	}
	@Override
	public void addCustomer(Customer customer) {
		customerDao.addCustomer(customer);
	}
	
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
        Double num =Math.ceil(tc/pageSize);//向上取整
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
	
	public void deleteCustomerById(int id) {//删除一个会员
		customerDao.deleteCustomerById(id);
	} 
	public void deleteCustomers(List<Integer> ids) { //删除多个会员
		customerDao.deleteCustomers(ids);
	}

}
