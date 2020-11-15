package com.javaee.vo;

public class FieldExistValidVO {

	private String fieldValue, fieldType;

	public String getFieldValue() {
		return fieldValue;
	}

	public void setFieldValue(String fieldValue) {
		this.fieldValue = fieldValue;
	}

	public String getFieldType() {
		return fieldType;
	}

	public void setFieldType(String fieldType) {
		this.fieldType = fieldType;
	}

	public FieldExistValidVO(String fieldValue, String fieldType) {
		this.fieldValue = fieldValue;
		this.fieldType = fieldType;
	}

	public FieldExistValidVO() {
		super();
	}
	
	
}
