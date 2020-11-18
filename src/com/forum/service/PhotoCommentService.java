package com.forum.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.forum.dao.CommentMapper;
import com.forum.dao.PhotoCommentMapper;
import com.forum.pojo.Comment;
import com.forum.pojo.PhotoComment;

@Repository
public class PhotoCommentService {

	@Autowired
	public PhotoCommentMapper photoCommentMapper;

	// 查询,三个id查询，三张表
	public List<PhotoComment> getPhotoComments(PhotoComment model) {
		try {
			return photoCommentMapper.getPhotoComments(model);
		} catch (Exception e) {
			List<PhotoComment> list = new ArrayList<PhotoComment>();
			return list;
		}
	}

	// 添加
	public boolean photoCommentSave(PhotoComment model) {
		try {
			photoCommentMapper.PhotoCommentSave(model);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	// 删除
	public boolean deleteById(Integer id) {
		try {
			photoCommentMapper.deleteById(id);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
}
