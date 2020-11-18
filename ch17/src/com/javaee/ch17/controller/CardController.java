package com.javaee.ch17.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaee.ch17.service.CardService;
import com.javaee.ch17.vo.FieldExistValidVO;

@Controller
public class CardController {

	@Autowired
	private CardService cardService;
	
	@ResponseBody
	@RequestMapping("isExistSameCard")
    public boolean ajaxValidateCard(@RequestBody FieldExistValidVO fieldExistValidVO) {
        return cardService.getSameCount(fieldExistValidVO)==1? true:false;
    }
	@ResponseBody
	@RequestMapping("isOtherExistSameCard")
    public boolean ajaxValidateCardOther(@RequestBody FieldExistValidVO fieldExistValidVO) {
        return cardService.getOtherSameCount(fieldExistValidVO)==1? true:false;
    }	
}
