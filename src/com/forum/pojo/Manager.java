package com.forum.pojo;

import java.io.Serializable;

public class Manager implements Serializable {
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String name;
	private String password;
	private String picture;
	private String dateTimes;
	
//	public Manager() {
//		super();
//		// TODO Auto-generated constructor stub
//	}
//	
//	public Manager(Integer id, String name, String password) {
//		super();
//		this.id = id;
//		this.name = name;
//		this.password = password;
//	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	public String getDateTimes() {
		return dateTimes;
	}
	public void setDateTimes(String dateTimes) {
		this.dateTimes = dateTimes;
	}
	
//	@Override
//	public String toString() {
//		return "Manager [id=" + id + ", name=" + name + ", password=" + password + ", picture=" + picture
//				+ ", dateTimes=" + dateTimes + "]";
//	}
	
	
	
}
