package com.javaee.vo;

import java.io.Serializable;
import java.util.Date;

public class ProductSearchVO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private int id;
	private String name;
	private double priceMin, priceMax;
	private Date entryTimeBegin, entryTimeEnd; // 录入时间的最小、最大值
	private Date modifyTimeBegin, modifyTimeEnd; // 修改时间的最小、最大值
	/**/
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
	public double getPriceMin() {
		return priceMin;
	}
	public void setPriceMin(double priceMin) {
		this.priceMin = priceMin;
	}
	public double getPriceMax() {
		return priceMax;
	}
	public void setPriceMax(double priceMax) {
		this.priceMax = priceMax;
	}
	public Date getEntryTimeBegin() {
		return entryTimeBegin;
	}
	public void setEntryTimeBegin(Date entryTimeBegin) {
		this.entryTimeBegin = entryTimeBegin;
	}
	public Date getEntryTimeEnd() {
		return entryTimeEnd;
	}
	public void setEntryTimeEnd(Date entryTimeEnd) {
		this.entryTimeEnd = entryTimeEnd;
	}
	public Date getModifyTimeBegin() {
		return modifyTimeBegin;
	}
	public void setModifyTimeBegin(Date modifyTimeBegin) {
		this.modifyTimeBegin = modifyTimeBegin;
	}
	public Date getModifyTimeEnd() {
		return modifyTimeEnd;
	}
	public void setModifyTimeEnd(Date modifyTimeEnd) {
		this.modifyTimeEnd = modifyTimeEnd;
	}	
	
}