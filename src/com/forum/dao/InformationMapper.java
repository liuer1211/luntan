package com.forum.dao;

import java.util.List;

import org.aspectj.lang.annotation.Aspect;

import com.forum.pojo.Information;
import com.forum.pojo.Manager;

@Aspect
public interface InformationMapper {
	// 查询
	public List<Information> getInformations(Information model);

	// 查询总记录
	public int getCount();

	// 分页查询
	public List<Information> getInformationPage(Information model);

	// 删除
	public void deleteById(Integer id);

	// add增加
	public void save(Information info);

	// update修改
	public void update(Information info);
}
