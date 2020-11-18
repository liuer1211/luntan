package com.forum.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.forum.dao.ArgumentMapper;
import com.forum.pojo.Argument;

@Repository
public class ArgumentService {
	@Autowired
	public ArgumentMapper argumentMapper;

	// 查询
	public List<Argument> getArguments(Argument model) {
		try {
			return argumentMapper.getArguments(model);
		} catch (Exception e) {
			List<Argument> list = new ArrayList<Argument>();
			return list;
		}
	}

	// 查询总记录
	public int getCount() {
		try {
			return argumentMapper.getCount();
		} catch (Exception e) {
			return -1;
		}
	}

	// 查询总记录,个人
	public int getCountOne(Integer id) {
		try {
			return argumentMapper.getCountOne(id);
		} catch (Exception e) {
			return -1;
		}
	}

	// 分页查询
	public List<Argument> getArgumentPage(Argument model) {
		try {
			return argumentMapper.getArgumentPage(model);
		} catch (Exception e) {
			List<Argument> list = new ArrayList<Argument>();
			return list;
		}
	}

	// 分页查询,个人
	public List<Argument> getArgumentPageOne(Argument model) {
		try {
			return argumentMapper.getArgumentPageOne(model);
		} catch (Exception e) {
			List<Argument> list = new ArrayList<Argument>();
			return list;
		}
	}

	// 添加
	public boolean argumentSave(Argument model) {
		try {
			argumentMapper.argumentSave(model);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	// 删除
	public boolean deleteById(Integer id) {
		try {
			argumentMapper.deleteById(id);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
}
