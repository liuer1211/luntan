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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.forum.pojo.Album;
import com.forum.pojo.Argument;
import com.forum.pojo.Comment;
import com.forum.pojo.Manager;
import com.forum.pojo.Photo;
import com.forum.pojo.User;
import com.forum.service.AlbumService;
import com.forum.service.ArgumentService;
import com.forum.service.CommentService;
import com.forum.service.ManagerService;
import com.forum.service.PhotoService;
import com.forum.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/manager")
public class ManPhotoController implements ServletContextAware {
	// 为上传文件做准备，找地址
	private ServletContext servletContext;

	@Override
	public void setServletContext(ServletContext context) {
		this.servletContext = context;
	}

	@Autowired
	PhotoService photoService;

	// 相片列表页面跳转
	@RequestMapping("/getPhotos")
	public ModelAndView getPhotos() {
		ModelAndView modelAndView = new ModelAndView("back/photo");
		return modelAndView;
	}

	// 相片列表数据
	@RequestMapping("/getPhotoList")
	@ResponseBody
	public ModelMap getPhotoList(HttpServletRequest request) {
		ModelMap modelMap = new ModelMap();
		Photo model = new Photo();
		// 获取页面传来的参数
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String title = request.getParameter("title");
		// 设置参数值
		model.setStartdate(startdate);
		model.setEnddate(enddate);
		model.setTitle(title);
		// 当前页码
		String currpage = request.getParameter("currpage");
		// 页面显示记录条数
		String pageSize = request.getParameter("pageSize");
		if (currpage != null && pageSize != null & !currpage.equals("") && !pageSize.equals("")) {
			PageHelper.startPage(Integer.parseInt(currpage), Integer.parseInt(pageSize));
		}
		List<Photo> list = photoService.getPhotos(model);
		PageInfo page = new PageInfo(list);
		modelMap.addAttribute("page", page);
		return modelMap;
	}
	
	// photoDelete删除
	@RequestMapping("/photoDelete")
	@ResponseBody
	public ModelMap photoDelete(HttpServletRequest request) {
		ModelMap modelMap = new ModelMap();
		// 获取页面选中的数据的 id
		String ids = request.getParameter("id");
		// 用逗号判断共有几条数据
		String[] idArray = ids.split(",");
		for (int i = 0; i < idArray.length; i++) {
			String obj = idArray[i];
			// 强转
			Integer id = Integer.parseInt(obj);
			// 批量删除
			photoService.deleteById(id);
		}
		return modelMap;
	}

}
