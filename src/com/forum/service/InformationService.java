package com.forum.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.forum.dao.InformationMapper;
import com.forum.pojo.Information;
import com.forum.pojo.Manager;

@Repository
public class InformationService {
	@Autowired
	public InformationMapper informationMapper;

	// 查询
	public List<Information> getInformations(Information model) {
		try {
			// 返回查到的数据
			return informationMapper.getInformations(model);
		} catch (Exception e) {
			// 返回空
			List<Information> list = new ArrayList<Information>();
			return list;
		}
	}

	// 查询总记录
	public int getCount() {
		try {
			return informationMapper.getCount();
		} catch (Exception e) {
			return -1;
		}
	}

	// 分页查询
	public List<Information> getInformationPage(Information model) {
		try {
			return informationMapper.getInformationPage(model);
		} catch (Exception e) {
			List<Information> list = new ArrayList<Information>();
			return list;
		}
	}

	// 删除
	public boolean deleteById(Integer id) {
		try {
			informationMapper.deleteById(id);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	// add增加
	public boolean save(Information info) {
		try {
			informationMapper.save(info);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	// update修改
	public boolean update(Information info) {
		try {
			informationMapper.update(info);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
}
