package com.forum.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.forum.dao.AlbumMapper;
import com.forum.pojo.Album;
import com.forum.pojo.User;

@Repository
public class AlbumService {
	@Autowired
	public AlbumMapper albumMapper;

	// 查询
	public List<Album> getAlbums(Album model) {
		try {
			return albumMapper.getAlbums(model);
		} catch (Exception e) {
			List<Album> list = new ArrayList<Album>();
			return list;
		}
	}

	// 删除
	public boolean albumDelete(Integer id) {
		try {
			albumMapper.albumDelete(id);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	// 添加
	public Boolean albumSave(Album model) {
		try {
			albumMapper.albumSave(model);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	// 删除
	public boolean deleteById(Integer id) {
		try {
			albumMapper.deleteById(id);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	// 修改
	public boolean update(Album model) {
		try {
			albumMapper.update(model);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
}
