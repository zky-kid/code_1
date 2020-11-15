package com.javaee.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaee.dao.AdministratorDao;
import com.javaee.po.Administrator;
import com.javaee.service.AdministratorService;
import com.javaee.vo.AdminVO;
import com.javaee.vo.LoginVO;

@Service
public class AdministratorServiceImpl implements AdministratorService {

	@Autowired
	private AdministratorDao administratorDao;
	@Override
	public Administrator findAdministratorById(int id) {
		
		return administratorDao.findAdministratorById(id);
	}

	@Override
	public Administrator findAdministratorByLogin(LoginVO loginVO) {
		
		return administratorDao.findAdministratorByLogin(loginVO);
	}

	@Override
	public int updateAdministratorPwd(AdminVO adminVO) {
		
		return administratorDao.updateAdministratorPwd(adminVO);
	}
	

}
