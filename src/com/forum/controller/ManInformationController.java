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
import com.forum.pojo.Information;
import com.forum.pojo.Manager;
import com.forum.pojo.Photo;
import com.forum.pojo.PhotoComment;
import com.forum.pojo.User;
import com.forum.service.AlbumService;
import com.forum.service.ArgumentService;
import com.forum.service.CommentService;
import com.forum.service.InformationService;
import com.forum.service.ManagerService;
import com.forum.service.PhotoCommentService;
import com.forum.service.PhotoService;
import com.forum.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/manager")
public class ManInformationController implements ServletContextAware {
	// 为上传文件做准备，找地址
	private ServletContext servletContext;

	@Override
	public void setServletContext(ServletContext context) {
		this.servletContext = context;
	}

	@Autowired
	InformationService informationService;

	// 新闻列表页面跳转
	@RequestMapping("/getInformations")
	public ModelAndView getInformations() {
		ModelAndView modelAndView = new ModelAndView("back/information");
		return modelAndView;
	}

	// 新闻列表数据
	@RequestMapping("/getInformationList")
	@ResponseBody
	public ModelMap getInformationList(HttpServletRequest request) {
		ModelMap modelMap = new ModelMap();
		Information model = new Information();
		// 获取页面传来的参数
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String title = request.getParameter("title");
		// 设置参数值
		model.setStartdate(startdate);
		model.setEnddate(enddate);
		model.setTitle(title);
		;
		// 当前页码
		String currpage = request.getParameter("currpage");
		// 页面显示记录条数
		String pageSize = request.getParameter("pageSize");
		if (currpage != null && pageSize != null & !currpage.equals("") && !pageSize.equals("")) {
			PageHelper.startPage(Integer.parseInt(currpage), Integer.parseInt(pageSize));
		}
		List<Information> list = informationService.getInformations(model);
		PageInfo page = new PageInfo(list);
		modelMap.addAttribute("page", page);
		return modelMap;
	}

	// informationDelete删除
	@RequestMapping("/informationDelete")
	@ResponseBody
	public ModelMap informationDelete(HttpServletRequest request) {
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
			informationService.deleteById(id);
		}
		return modelMap;
	}

	// add添加，页面跳转
	@RequestMapping("/addInformationView")
	public ModelAndView addInformationView() {
		ModelAndView modelAndView = new ModelAndView("back/informationAdd");
		return modelAndView;
	}

	// add添加
	@RequestMapping("/informationAdd")
	@ResponseBody
	public ModelAndView add(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView("back/information");
		// 1.得到服务器地址
		String path = this.servletContext.getRealPath("/tmp/");
		// System.out.println("path——————————————————————"+path);
		// ModelMap modelMap =new ModelMap();
		try {
			Information model = new Information();
			String title = request.getParameter("title");
			String link = request.getParameter("link");
			String content = request.getParameter("content");
			// String file=request.getParameter("picture");
			// 2.获得文件 名字
			MultipartHttpServletRequest mreq = (MultipartHttpServletRequest) request;
			MultipartFile file = mreq.getFile("picture");
			String fileName = file.getOriginalFilename();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			// 3.先定义
			String newfile = sdf.format(new Date()) + fileName.substring(fileName.lastIndexOf('.'));
			// 4.再使用
			FileOutputStream fos = new FileOutputStream(path + newfile);
			// System.out.println("fos------"+fos);
			// System.out.println("newfile====="+newfile);
			// 5.关闭流
			fos.write(file.getBytes());
			fos.flush();
			fos.close();
			// 6.设置文件，准备添加到数据库
			model.setPicture(newfile);

			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
			model.setDateTimes(df.format(new Date()));

			model.setTitle(title);
			model.setLink(link);
			model.setContent(content);

			informationService.save(model);

			// 如果添加成功，传递success：true，前台以此作为关闭弹出框的依据
			// modelMap.addAttribute("success",
			// Boolean.TRUE);//Boolean.TRUE，直接写成true，不对
		} catch (Exception ex) {
			// 加一个error
			// modelMap.addAttribute("success", Boolean.FALSE);
		}
		return modelAndView;
	}

	// 编辑edit,页面跳转，必须有参数传递
	@RequestMapping("/editInformationView")
	public ModelAndView editView(HttpServletRequest request) {
		String id = request.getParameter("id");
		Information model = new Information();
		model.setId(Integer.parseInt(id));
		List<Information> list = informationService.getInformations(model);
		ModelAndView modelAndView = new ModelAndView("back/informationEdit");
		modelAndView.addObject("info", list.get(0));
		return modelAndView;
	}

	// edit编辑
	@RequestMapping("/informationUpdate")
	@ResponseBody
	public ModelMap update(HttpServletRequest request) {
		ModelMap modelMap = new ModelMap();
		try {
			Information model = new Information();
			String id = request.getParameter("id");
			String link = request.getParameter("link");
			String content = request.getParameter("content");

			model.setId(Integer.parseInt(id));
			model.setLink(link);
			model.setContent(content);

			informationService.update(model);
			modelMap.addAttribute("success", Boolean.TRUE);

		} catch (Exception ex) {
			modelMap.addAttribute("success", Boolean.FALSE);
		}
		return modelMap;
	}

}
