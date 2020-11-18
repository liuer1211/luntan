package com.forum.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.forum.dao.AlbumMapper;
import com.forum.dao.PhotoMapper;
import com.forum.pojo.Album;
import com.forum.pojo.Photo;

@Repository
public class PhotoService {
	@Autowired
	public PhotoMapper photoMapper;
	
	//查询
	public List<Photo> getPhotos(Photo model){
		try {
			return photoMapper.getPhotos(model);
		} catch (Exception e) {
			List<Photo> list=new ArrayList<Photo>();
			return list;
		}
	}
	//添加
	public boolean photoSave(Photo model){
		try {
			photoMapper.photoSave(model);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	// 删除
		public boolean deleteById(Integer id) {
			try {
				photoMapper.deleteById(id);
				return true;
			} catch (Exception e) {
				return false;
			}
		}
	
}
