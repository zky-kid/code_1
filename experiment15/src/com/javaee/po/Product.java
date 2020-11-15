package com.javaee.po;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class Product implements Serializable {//商品实体
	private static final long serialVersionUID = 1L;
	
	private int id;
	private String name;
	private double price;
	private Date entryTime; // 记录的录入时间 后增此列。
	private Date modifyTime; // 记录的修改时间 后增此列
	private List<Order> listOrder; // 商品与订单 多对多关联的商品一方
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	
	public Date getEntryTime() {
		return entryTime;
	}
	public void setEntryTime(Date entryTime) {
		this.entryTime = entryTime;
	}
	
	public Date getModifyTime() {
		return modifyTime;
	}
	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}
	public List<Order> getListOrder() {
		return listOrder;
	}
	public void setListOrder(List<Order> listOrder) {
		this.listOrder = listOrder;
	}
	
	public String toString() {
		return "Product [ id="+ id +", name=" + name + ", price=" + price+"]";
	}
	
}
/*

create table t_product(
	id int primary key auto_increment,
	name varchar(50),
	price decimal(10,2),
	entryTime datetime(6) default now(6),
	modifyTime datetime(6)
);

alter table t_product
    add column entryTime datetime(6),
    add column modifyTime datetime(6);
# 将来的扩展：可再考虑库存方面，如：总进货量、现存量
insert into t_product(name, price) values
('Java程序设计基础', 44.5),
('Java Web程序设计教程', 52),
('Java EE项目实训', 60),
('数据结构(Java版)',31);
 * */
