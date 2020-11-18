package com.forum.controller;

import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.forum.pojo.Album;
import com.forum.pojo.User;
import com.forum.service.AlbumService;
import com.forum.service.UserService;

@Controller
@RequestMapping("/album")
public class AlbumController implements ServletContextAware {
	// 为上传文件做准备，找地址
	private ServletContext servletContext;

	@Override
	public void setServletContext(ServletContext context) {
		this.servletContext = context;
	}

	@Autowired
	public AlbumService albumService;
	@Autowired
	public UserService userService;
	
	@RequestMapping("/albumStart")
	public ModelAndView getAlbumView(HttpServletRequest request){
		ModelAndView modelAndView1=new ModelAndView("front/album");
		ModelAndView modelAndView2 = new ModelAndView("front/login");
//		String id=request.getParameter("id");
		Album model=new Album();
//		if(!"".equals(id)){
//			model.setUserId(Integer.parseInt(id));
			List<Album> listOne = albumService.getAlbums(model);
			//防止空指针异常
			if(listOne.size()>0){
				//不能使用listOne.get(0);因为这里listOne是多个集合
				request.setAttribute("listOne", listOne);
//				System.out.println("****"+listOne);//输出：[com.forum.pojo.Album@5a9637c9, com.forum.pojo.Album@3c289b95]
				return modelAndView1;
			}else{
				//如果没有，跳过去；前台要做判断
				request.setAttribute("listOne", listOne);
//				System.out.println("++++++++++"+listOne);//输出[]
				return modelAndView1;
			}
//		}
//		else{
//			return modelAndView2;
//		}
	}

	//删除
	@RequestMapping("/albumDelete")
	public String albumDelete(HttpServletRequest request) {
//		ModelAndView modelAndView=new ModelAndView("/front/success");
		String id = request.getParameter("id");
		//删除
		albumService.albumDelete(Integer.parseInt(id));
		return "redirect:/index.jsp";
	}
	
	//添加相册，跳转
	@RequestMapping("/albumAddView")
	public ModelAndView albumAddView(HttpServletRequest request) {
		ModelAndView modelAndView1=new ModelAndView("/front/albumAdd");
		ModelAndView modelAndView2=new ModelAndView("/front/login");
		String userId = request.getParameter("id");
		User model=new User();
		//判断用户id是否存在，是否登陆
		if(!"".equals(userId)){
			model.setId(Integer.parseInt(userId));
			//查询用户
			List<User> listUserOne = userService.getUsers(model);
			if(listUserOne.size()>0){
				//用户存在，传递用户id
				request.setAttribute("listUserOne", listUserOne.get(0));
				return modelAndView1;
			}else {
				return modelAndView2;
			}
		}else{
			return modelAndView2;
		}
	}
	
	//添加相册
	@RequestMapping("/albumSave")
	public String albumSave(HttpServletRequest request) {
//		ModelAndView modelAndView1=new ModelAndView("front/success");
//		ModelAndView modelAndView2=new ModelAndView("front/login");
		String userId = request.getParameter("userId");
		String title = request.getParameter("title");
		//1.得到服务器地址
		String path =this.servletContext.getRealPath("/tmp/");
//		System.out.println("path----"+path);
		//获取文件  名字，页面上的
		MultipartHttpServletRequest mrep=(MultipartHttpServletRequest) request;
		MultipartFile file=mrep.getFile("picture");
		Album model=new Album();
		//判断
		if(!"".equals(userId)){
			model.setUserId(Integer.parseInt(userId));
			model.setTitle(title);
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			model.setCreateDate(sdf1.format(new Date()));
//			//默认加图片，如果选择了，就执行修改操作，把图片换掉
//			model.setPicture("xc.jpg");
//			//不选择图片
//			albumService.albumSave(model);
			
			//选择图片后
			try {
				//2-1.对文件进行处理
				String fileName = file.getOriginalFilename();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				//3.先定义
				String newfile=sdf.format(new Date())+fileName.substring(fileName.lastIndexOf('.'));
				//4.在使用
				FileOutputStream fos=new FileOutputStream(path+newfile);
				//5.关闭流
				fos.write(file.getBytes());
				fos.flush();
				fos.close();
				//6.设置文件，添加数据库
				model.setPicture(newfile);
				//
				albumService.albumSave(model);
			} catch (Exception e) {
			}
			return "redirect:/index.jsp";
		}else{
			return "front/login";
		}
	} 
	
}
