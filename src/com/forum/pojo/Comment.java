package com.forum.pojo;

import java.io.Serializable;

public class Comment implements Serializable {
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String content;
	private String dateTimes;
	private Integer argumentId;
	private Integer userId;

	// 时间范围
	private String startdate;
	private String enddate;

	public String getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}

	public String getEnddate() {
		return enddate;
	}
	
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}

	// 三表联立user和argument
	private String name;
	private String picture;
	private String title;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getDateTimes() {
		return dateTimes;
	}

	public void setDateTimes(String dateTimes) {
		this.dateTimes = dateTimes;
	}

	public Integer getArgumentId() {
		return argumentId;
	}

	public void setArgumentId(Integer argumentId) {
		this.argumentId = argumentId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

}
