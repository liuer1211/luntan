package com.forum.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.forum.dao.CommentMapper;
import com.forum.pojo.Comment;

@Repository
public class CommentService {
	
	@Autowired
	public CommentMapper commentMapper;
	
	//查询,三个id查询，三张表
	public List<Comment> getComments(Comment model){
		try {
			return commentMapper.getComments(model);
		} catch (Exception e) {
			List<Comment> list=new ArrayList<Comment>();
			return list;
		}
	}
	
	//查询，comment，一张表
	public List<Comment> getOneComments(Comment model){
		try {
			return commentMapper.getOneComments(model);
		} catch (Exception e) {
			List<Comment> list=new ArrayList<Comment>();
			return list;
		}
	}
	
   //查询,中间桥梁
   public List<Comment> getArguComments(Comment model){
	   try {
			return commentMapper.getArguComments(model);
		} catch (Exception e) {
			List<Comment> list=new ArrayList<Comment>();
			return list;
		}
   }
   
   //添加
   public boolean commentSave(Comment model){
	   try {
		   commentMapper.commentSave(model);
		   return true;
	   } catch (Exception e) {
		   return false;
	   }
   }
   
   // 删除
	public boolean deleteById(Integer id) {
		try {
			commentMapper.deleteById(id);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
   
}
