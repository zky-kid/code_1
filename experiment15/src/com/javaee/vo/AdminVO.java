package com.javaee.vo;

import java.io.Serializable;

import com.javaee.po.Administrator;

public class AdminVO implements Serializable{

	private static final long serialVersionUID = 1L;

	private Administrator administrator;
	private String newPwd;
	public Administrator getAdministrator() {
		return administrator;
	}
	public void setAdministrator(Administrator administrator) {
		this.administrator = administrator;
	}
	public String getNewPwd() {
		return newPwd;
	}
	public void setNewPwd(String newPwd) {
		this.newPwd = newPwd;
	}
	
}
