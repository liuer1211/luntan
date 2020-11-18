package com.forum.dao;

import java.util.List;

import org.aspectj.lang.annotation.Aspect;

import com.forum.pojo.Comment;
import com.forum.pojo.PhotoComment;

@Aspect
public interface PhotoCommentMapper {
	// 查询,三个id查询，三张表
	public List<PhotoComment> getPhotoComments(PhotoComment model);

	// 添加
	public void PhotoCommentSave(PhotoComment model);

	// 删除
	public void deleteById(Integer id);
}
