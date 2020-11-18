package com.forum.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.forum.dao.UserMapper;
import com.forum.pojo.User;

@Repository
public class UserService {
	@Autowired
	public UserMapper userMapper;
	
	//查询
	public List<User> getUsers(User model){
		try{
			return userMapper.getUsers(model);
		}
		catch(Exception e){
			List<User> list= new ArrayList<>();
			return list;
		}
	}
	//精确 查询  验证用户唯一性
	public List<User> getUserInfo(User model){
		try{
			return userMapper.getUserInfo(model);
		}
		catch(Exception e){
			List<User> list= new ArrayList<>();
			return list;
		}
	}
	//增加
	public boolean save(User model){
		try {
			userMapper.save(model);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	//修改
	public boolean update(User model) {
		try{
			userMapper.update(model);
			return true;
		}catch(Exception e){
			return false;
		}
	}
	//删除
	public boolean deleteById(Integer id) {
		try{
			userMapper.deleteById(id);
			return true;
		}catch(Exception e){
			return false;
		}
	}
	//登录 精确查找
	public List<User> getUserOne(User model) {
		try{
			return userMapper.getUserOne(model);
		}
		catch(Exception e){
			List<User> list= new ArrayList<>();
			return list;
		}
	}
	//查询用户，用来做用户最近动态，登录时间
	public List<User> getUserLoginDate(User model) {
		try{
			return userMapper.getUserLoginDate(model);
		}catch(Exception e){
			List<User> list= new ArrayList<>();
			return list;
		}
	}
	
}
