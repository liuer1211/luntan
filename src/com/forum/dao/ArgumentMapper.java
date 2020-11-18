package com.forum.dao;

import java.util.List;

import org.aspectj.lang.annotation.Aspect;

import com.forum.pojo.Argument;

@Aspect
public interface ArgumentMapper {
	//查询
	public List<Argument> getArguments(Argument model);
	//查询总记录
	public int getCount();
	//查询总记录,个人
	public int getCountOne(Integer id);
	//分页查询
	public List<Argument> getArgumentPage(Argument model);
	//分页查询,个人
	public List<Argument> getArgumentPageOne(Argument model);
	//添加
	public void argumentSave(Argument model);
	//删除
	public void deleteById(Integer id);
}
