package com.forum.dao;

import java.util.List;

import org.aspectj.lang.annotation.Aspect;

import com.forum.pojo.Album;
import com.forum.pojo.User;

@Aspect
public interface AlbumMapper {
	//查询
	public List<Album> getAlbums(Album model);
	//删除
	public void albumDelete(Integer id);
	//添加
	public void albumSave(Album model);
	//删除
	public void deleteById(Integer id);
	//修改
	public void update(Album model);
}
