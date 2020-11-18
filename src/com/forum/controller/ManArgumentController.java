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

import com.forum.pojo.Argument;
import com.forum.pojo.Manager;
import com.forum.pojo.User;
import com.forum.service.ArgumentService;
import com.forum.service.ManagerService;
import com.forum.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/manager")
public class ManArgumentController implements ServletContextAware {
	// 为上传文件做准备，找地址
	private ServletContext servletContext;

	@Override
	public void setServletContext(ServletContext context) {
		this.servletContext = context;
	}

	@Autowired
	ArgumentService argumentService;

	// 言论列表页面跳转
	@RequestMapping("/getArguments")
	public ModelAndView getArguments() {
		ModelAndView modelAndView = new ModelAndView("back/argument");
		return modelAndView;
	}

	// 言论列表数据
	@RequestMapping("/getArgumentList")
	@ResponseBody
	public ModelMap getArgumentList(HttpServletRequest request) {
		ModelMap modelMap = new ModelMap();
		Argument model = new Argument();
		// 获取页面传来的参数
		String title = request.getParameter("title");
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String property = request.getParameter("property");
		// 设置参数值
		model.setTitle(title);
		model.setStartdate(startdate);
		model.setEnddate(enddate);
		model.setProperty(property);
		// 当前页码
		String currpage = request.getParameter("currpage");
		// 页面显示记录条数
		String pageSize = request.getParameter("pageSize");
		if (currpage != null && pageSize != null & !currpage.equals("") && !pageSize.equals("")) {
			PageHelper.startPage(Integer.parseInt(currpage), Integer.parseInt(pageSize));
		}
		List<Argument> list = argumentService.getArguments(model);
		PageInfo page = new PageInfo(list);
		modelMap.addAttribute("page", page);
		return modelMap;
	}

	// argumentDelete删除
	@RequestMapping("/argumentDelete")
	@ResponseBody
	public ModelMap argumentDelete(HttpServletRequest request) {
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
			argumentService.deleteById(id);
		}
		return modelMap;
	}

}
