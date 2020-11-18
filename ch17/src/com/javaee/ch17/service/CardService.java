package com.javaee.ch17.service;

import com.javaee.ch17.po.Card;
import com.javaee.ch17.vo.FieldExistValidVO;

public interface CardService {
	public Card findCardById(int id);
	public int getSameCount(FieldExistValidVO fieldExistValidVO);
	public int getOtherSameCount(FieldExistValidVO fieldExistValidVO);
	public int insertCard(Card card);
	public int deleteCard(int id);
	public int updateCard(Card card);
}
