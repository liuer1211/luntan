package com.forum.pojo;

import java.io.Serializable;

public class Friend implements Serializable{
	private static final long serialVersionUID=1L;
	private Integer id;
	private Integer friendId;
	private Integer userId;
	private String dateTimes;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getFriendId() {
		return friendId;
	}
	public void setFriendId(Integer friendId) {
		this.friendId = friendId;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getDateTimes() {
		return dateTimes;
	}
	public void setDateTimes(String dateTimes) {
		this.dateTimes = dateTimes;
	}
	
}
