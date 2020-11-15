package com.javaee.vo;

import com.javaee.po.Customer;

public class CustomerRegisterValidVO {
	private Customer customer;
	private String fieldType;
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public String getFieldType() {
		return fieldType;
	}
	public void setFieldType(String fieldType) {
		this.fieldType = fieldType;
	}
	
	
}
