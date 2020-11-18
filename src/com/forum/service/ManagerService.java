package com.forum.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.forum.dao.ManagerMapper;
import com.forum.pojo.Manager;

@Repository
public class ManagerService {

	@Autowired
	public ManagerMapper managerMapper;
	
	//select查询
	public List<Manager> getManagers(Manager model) {
		try {
//			System.out.println("***************************************");
//			System.out.println("*-*-*-:"+managerMapper.getManagers(model));
//			System.out.println("+**+*****++++***+++***+++");
//			List<Manager> list = managerMapper.getManagers(model);
			return managerMapper.getManagers(model);
		} catch (Exception e) {
			List<Manager> list= new ArrayList<>();
//			System.out.println("++++++++++++++++++++++++++++++");
			return list;
		}
	}
	
	//add增加
	public boolean save(Manager info)
	{
		try {
			managerMapper.save(info);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	
	//update修改
	public boolean update(Manager info)
	{
		try {
			managerMapper.update(info);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	
	//删除
	public boolean deleteById(Integer id)
	{
		try {
			managerMapper.deleteById(id);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
}
