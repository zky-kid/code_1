package com.javaee.po;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class Order implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private int id;
	private String orderNo;
	private Customer customer; //private int customerID; 如写成这样只能得到会员号而已，这个下单人的其它信息则要再次查数据库才能得到。
	private Date orderDate;
	private double totalSum;
	
	private List<Product> listProduct; // 商品与订单 多对多关联的商品一方
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	/*
	public int getCustomerID() {
		return customerID;
	}
	public void setCustomerID(int customerID) {
		this.customerID = customerID;
	}
	*/
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}	
	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	public double getTotalSum() {
		return totalSum;
	}
	public void setTotalSum(double totalSum) {
		this.totalSum = totalSum;
	}
	
	public List<Product> getListProduct() {
		return listProduct;
	}
	public void setListProduct(List<Product> listProduct) {
		this.listProduct = listProduct;
	}
	
	public String toString() {
		//return "订单[" + id +", 订单号=" + orderNo + ", 下单会员号=" + customerID + ", 下单日期=" + orderDate+", 金额=" + totalSum + "]"; 
		return "订单[" + id +", 订单号=" + orderNo + ", 下单会员号=" + customer.getId() + ", 下单日期=" + orderDate+", 金额=" + totalSum + "]"; 
	}
	public String toStringwithProduct() {
		//return "订单[" + id +", 订单号=" + orderNo + ", 下单会员号=" + customerID + ", 下单日期=" + orderDate+", 金额=" + totalSum + ", \n选购商品信息="+listProduct +"]"; 
		return "订单[" + id +", 订单号=" + orderNo + ", 下单会员号=" + customer.getId() + ", 下单日期=" + orderDate+", 金额=" + totalSum + ", \n选购商品信息="+listProduct +"]"; 
	}	
}
/*
create table t_order(
	id int primary key auto_increment,
	orderNo varchar(32) not null,
	customer_id int not null references Customer(id),
	orderDate datetime(6),
	totalSum decimal(10,2) default 0
);
insert into t_order(orderNo, customer_id, orderDate, totalSum) values
('20191110092115001', 1, '2019-11-10 09:21:15.355690', 160.5),
('20191110093547001', 2, '2019-11-10 09:35:47.211702', 115),
('20191111120936002', 3, '2019-11-11 12:09:36.523804', 95),
('20191111120952005', 1, '2019-11-11 12:09:52.076329', 500);

----------
创建多对多关联的中间表 订单明细表t_orderDetail
create table t_orderDetail(
	id int primary key auto_increment,
	order_id int not null references t_order(id),
	product_id int not null references t_product(id),
	price decimal(10,2),
	quantity decimal(10,2)
);
# 分别表示 id、 订单号、商品号、下单时的价格、商品数量
insert into t_orderDetail(order_id, product_id, price, quantity) values
(1, 1, 44.5, 2),
(1, 3, 71.5, 1),
(2, 1, 44.5, 2),
(2, 2, 26, 1),
(3, 3, 57, 1),
(3, 4, 28, 1),
(4, 3, 50, 10)
;
 */