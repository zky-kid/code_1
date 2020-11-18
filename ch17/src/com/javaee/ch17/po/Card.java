package com.javaee.ch17.po;

import java.io.Serializable;
import java.sql.Date;

public class Card implements Serializable {

	private static final long serialVersionUID = 1L;

	private int id;
	private int cardType; // 默认值是0，表示身份证
	private String cardNo;
	private Date startDate, endDate;
	private String issuingAuthority;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCardType() {
		return cardType;
	}
	public void setCardType(int cardType) {
		this.cardType = cardType;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public String getIssuingAuthority() {
		return issuingAuthority;
	}
	public void setIssuingAuthority(String issuingAuthority) {
		this.issuingAuthority = issuingAuthority;
	}
	
}

/*
CREATE TABLE card  (
  id int AUTO_INCREMENT primary key,
  cardType tinyint(4) ,
  cardNo varchar(30),
  startDate date,
  endDate date,
  issuingAuthority varchar(50)
) 
*/