package com.javaee.po;

import java.io.Serializable;

public class Administrator implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private int id;
	private String adminName, adminPwd;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public String getAdminPwd() {
		return adminPwd;
	}
	public void setAdminPwd(String adminPwd) {
		this.adminPwd = adminPwd;
	}
	
}
/*
create table t_admin(
   id tinyint auto_increment primary key,
   adminName varchar(20) not null unique,
   adminPwd varchar(30) not null
);

 * 
 */
