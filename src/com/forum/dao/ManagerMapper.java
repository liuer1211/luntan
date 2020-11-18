package com.forum.dao;

import java.util.List;

import org.aspectj.lang.annotation.Aspect;

import com.forum.pojo.Manager;
@Aspect
public interface ManagerMapper {
	//得到id
	public Manager getManagerById(Integer id);
	//select查询
	public List<Manager> getManagers(Manager model);
	//add增加
	public void save(Manager info);
	//update修改
	public void update(Manager info);
	//删除
	public void deleteById(Integer id);
}
