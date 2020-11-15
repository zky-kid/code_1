package com.javaee.po;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class Customer implements Serializable { // 实体类，一般都要实现可串行化接口Serializable，以常驻内存，便于系统各层调用。
	private static final long serialVersionUID = 1L;
	
	private int id; // 客户编号 自增 主键
	private String userName; // 客户登录用户名 希望是非空且不重复
	private String password; // 客户登录密码
	private String userRealName; // 客户真名
	private String gender; // 客户性别： 字符‘0’、‘1’分别表示'男'、'女'。默认值是'0'
	private String email; //客户邮箱 如特别重要，该字段应设成非空且不重复。
	private String contactPhone; // 客户联系电话：可有多个手机、电话
	private String address; // 客户联系地址 可再细分：省/直辖市、市、区/县、镇等子级、余下的。在jsp页上：下拉框级联选前面，手工输入余下的。大型电商网站、学历教育等有类似这么操作。
	private Date creationTime; // 建立时间 默认值是做insert操作（可能是游客自己注册或由操作员添加）时的时刻点。
	private Date lastChangeTime; // 最近一次修改个人信息的日期时间
	private Date loginTime; // 最近一次登录时间  对于客户自己来说，这两个字段是本次登录的时间和IP
	private Date loginIP; // 最近一次登录时的IP地址 关于字段长度（暂只考虑IPv4情况即四个不超过255的数字被3个点间隔）：123.123.123.123
	private List<Order> listOrder; // 一个会员对应多个订单
	// 属性名称/顺序宜与DB该表的列名/顺序一致。
	//           次序不一致，是给开发者自己平添烦扰。没理由也不值得！
	
	// 此外还可根据需要考虑这些属性：
	// 身份证号、生日、职业名称、工作单位、客户级别(普通、VIP)、积分(历史总积分、目前可用积分)、卡号、登录日志(上一次登录的时间与IP地址)、备注等。
	// 比如：
	//     1. 在酒店管理系统中，还要考虑客人是否在黑名单中（被拉黑的时间、理由、操作员）
	//     2. 在有严格会员审核功能的等系统中，要考虑设置同意注册的审核信息(审核人/时间) 
	//     3. 为确保手机、邮箱被冒用，针对注册、密码找回功能的模块中，可能要考虑再添置验证码(发到手机或邮箱)及其有效期。
	/*
	create table Customer(
		id int primary key auto_increment,		
		userName varchar(30) not null unique,
		password varchar(32) not null,
		userRealName varchar(20),
		gender char(1) default '0',
		email varchar(40),
		contactPhone varchar(50),
		address varchar(100),
		creationTime datetime(6) default now(6),
		loginTime datetime(6),
		loginIP varchar(15)
	);
	insert into Customer(userName, password, userRealName, gender, email, contactPhone, address) values
	   ('javaeeSSM', 'weqsj92', '学习者',  '0', 'ssm@qq.com', '13012345678', '广东省广州市天河区龙洞街29号'),
	   ('jerryTom', '190152kk', '汤姆杰瑞',  '0', 'myEmail01@sina.com.cn', '13612345611', '广东省广州市越秀区人民南路86号'),
	   ('boniu1024', '2011168841', '播妞学姐',  '1', 'boniu_01@itheima.com', '010-81055256, 18955345002', '北京市丰台区传智播客旗舰店');
	这两条SQL语句可复制并粘贴到已登录并进入MySQL的spring数据库的cmd界面中执行（先create，然后再insert）。
	 */
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUserRealName() {
		return userRealName;
	}
	public void setUserRealName(String userRealName) {
		this.userRealName = userRealName;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getContactPhone() {
		return contactPhone;
	}
	public void setContactPhone(String contactPhone) {
		this.contactPhone = contactPhone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Date getCreationTime() {
		return creationTime;
	}
	public void setCreationTime(Date creationTime) {
		this.creationTime = creationTime;
	}
	public Date getLastChangeTime() {
		return lastChangeTime;
	}
	public void setLastChangeTime(Date lastChangeTime) {
		this.lastChangeTime = lastChangeTime;
	}
	public Date getLoginTime() {
		return loginTime;
	}
	public void setLoginTime(Date loginTime) {
		this.loginTime = loginTime;
	}
	public Date getLoginIP() {
		return loginIP;
	}
	public void setLoginIP(Date loginIP) {
		this.loginIP = loginIP;
	}
	
	
	
	public List<Order> getListOrder() {
		return listOrder;
	}
	public void setListOrder(List<Order> listOrder) {
		this.listOrder = listOrder;
	}
	// 为了在控制台便于显示该对象的各字段值，所以特意重写toString()方法。否则，是那种默认的 完整包名@十六进制数  这是并无大的实际意义。
	public String toString() {
		return "id:"+ id + ", userName:" + userName + ", password: " + password + ", userRealName:" + userRealName + ", gender:" + gender 
				+ ", email:" + email + ", contactPhone:" + contactPhone +", address:" + address 
				+ ", creationTime:" + creationTime;  
		
	}	
	public String toStringWithOrders() {
		return "会员[ id:"+ id + ", userName:" + userName + ", userRealName:" + userRealName + ", gender:" + gender 
				+ ", email:" + email + ", contactPhone:" + contactPhone +", address:" + address 
				+ ", listOrder:\n" + listOrder+"]";  
		
	}
}
