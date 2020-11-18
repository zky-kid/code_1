package com.javaee.ch17.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaee.ch17.dao.CardDao;
import com.javaee.ch17.po.Card;
import com.javaee.ch17.service.CardService;
import com.javaee.ch17.vo.FieldExistValidVO;
@Service
public class CardServiceImpl implements CardService {

	@Autowired
	private CardDao cardDao;
	
	@Override
	public Card findCardById(int id) {
		return cardDao.findCardById(id);
	}
	
	public int getSameCount(FieldExistValidVO fieldExistValidVO) {
		return cardDao.getSameCount(fieldExistValidVO);
	}
	
	public int getOtherSameCount(FieldExistValidVO fieldExistValidVO) {
		return cardDao.getOtherSameCount(fieldExistValidVO);
	}

	@Override
	public int insertCard(Card card) {
		return cardDao.insertCard(card);
	}

	@Override
	public int deleteCard(int id) {
		return cardDao.deleteCard(id);
	}

	@Override
	public int updateCard(Card card) {
		return cardDao.updateCard(card);
	}

}
