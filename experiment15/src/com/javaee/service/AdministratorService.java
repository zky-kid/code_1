package com.javaee.service;

import com.javaee.po.Administrator;
import com.javaee.vo.AdminVO;
import com.javaee.vo.LoginVO;

public interface AdministratorService {
	public Administrator findAdministratorById(int id);
	public Administrator findAdministratorByLogin(LoginVO loginVO);
	public int updateAdministratorPwd(AdminVO adminVO);
}
