package com.forum.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.xml.ws.RespectBinding;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.forum.pojo.Comment;
import com.forum.pojo.Photo;
import com.forum.pojo.PhotoComment;
import com.forum.service.PhotoCommentService;
import com.forum.service.PhotoService;

@Controller
@RequestMapping("/photoComment")
public class PhotoCommentController {
	@Autowired
	public PhotoCommentService photoCommentService;
	
	@Autowired
	public PhotoService photoService;
	
	//跳转照片评论，传数据
	@RequestMapping("/photoCommentStart")
	public ModelAndView getPhotoCommentView(HttpServletRequest request){
		ModelAndView modelAndView=new ModelAndView("front/photoComment");
		ModelAndView modelAndView1=new ModelAndView("front/login");
		String photoId = request.getParameter("photoId");
		Photo modelPhoto=new Photo();
		modelPhoto.setId(Integer.parseInt(photoId));
		List<Photo> listPh = photoService.getPhotos(modelPhoto);
		if(listPh.size()>0){
			List<Photo> listPhotoOne = photoService.getPhotos(modelPhoto);
			//有相册，用户信息
			request.setAttribute("listPhotoOne", listPhotoOne.get(0));
			//查询有多少评论
			PhotoComment model=new PhotoComment();
			model.setPhotoId(Integer.parseInt(photoId));
			List<PhotoComment> list = photoCommentService.getPhotoComments(model);
			request.setAttribute("list", list);
			return modelAndView;
		}else {
			return modelAndView1;
		}
	}

	//添加评论
	@RequestMapping("/photoCommentSave")
	public String photoCommentSave(HttpServletRequest request) {
//		ModelAndView modelAndView1=new ModelAndView("front/success");
//		ModelAndView modelAndView2=new ModelAndView("front/login");
		String photoId = request.getParameter("photoId");
		String userId = request.getParameter("userId");
		String content = request.getParameter("content");
		PhotoComment model=new PhotoComment();
		//判断用户是否登陆
		if(!"".equals(userId)){
			//获得设置
			model.setPhotoId(Integer.parseInt(photoId));
			model.setUserId(Integer.parseInt(userId));
			model.setContent(content);
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
			model.setCommentDate(df.format(new Date()));
			//添加
			boolean bool = photoCommentService.photoCommentSave(model);
			if(bool==true){
				return "redirect:/index.jsp";
			}else{
				return "front/login";
			}
		}else {
			return "front/login";
		}
	}
	
	
}
