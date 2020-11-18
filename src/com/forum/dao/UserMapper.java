package com.forum.dao;

import java.util.List;

import org.aspectj.lang.annotation.Aspect;

import com.forum.pojo.User;
@Aspect
public interface UserMapper {
	//查询
	public List<User> getUsers(User model);
	//精确 查询  验证用户唯一性
	public List<User> getUserInfo(User model);
	//增加
	public void save(User model);
	//修改
	public void update(User model);
	//删除
	public void deleteById(Integer id);
	//登录，精确查找
	public List<User> getUserOne(User model);
	//查询用户，用来做用户最近动态，登录时间
	public List<User> getUserLoginDate(User model);
	
}
