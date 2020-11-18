package com.forum.dao;

import java.util.List;

import org.aspectj.lang.annotation.Aspect;

import com.forum.pojo.Comment;

@Aspect
public interface CommentMapper {
	//查询,三个id查询，三张表
	public List<Comment> getComments(Comment model);
	//查询，comment，一张表
	public List<Comment> getOneComments(Comment model);
	//查询,中间桥梁
	public List<Comment> getArguComments(Comment model);
	//添加
	public void commentSave(Comment model);
	//删除
	public void deleteById(Integer id);
}
