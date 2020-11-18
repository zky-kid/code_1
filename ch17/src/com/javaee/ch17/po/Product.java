package com.javaee.ch17.po;

import java.io.Serializable;
import java.util.Date;

public class Product implements Serializable {

	private int id;
	private String name;
	private double price;
	//private int categoryId; // 为了便于封装，常将外键写成它对应的实体。所以不建议照直写外键本身。
	private Category category;
	private Date entryTime, modifyTime;
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
	public Category getCategory() {
		return category;
	}
	public void setCategory(Category category) {
		this.category = category;
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

	
}
/*

create table Product(
  id int auto_increment primary key,
  name varchar(50),
  price decimal(10, 2),
  categoryId int,
  entryTime datetime(6),
  modifyTime datetime(6) default now(6),
  foreign key(categoryId) references Category(id)
)
*/
