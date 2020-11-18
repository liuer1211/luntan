package com.forum.dao;

import java.util.List;

import org.aspectj.lang.annotation.Aspect;

import com.forum.pojo.Album;
import com.forum.pojo.Photo;

@Aspect
public interface PhotoMapper {
	//查询
	public List<Photo> getPhotos(Photo model);
	//添加
	public void photoSave(Photo model);
	//删除
	public void deleteById(Integer id);
}
