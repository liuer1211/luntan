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

import com.forum.pojo.Manager;
import com.forum.service.ManagerService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/manager")
public class ManagerController implements ServletContextAware {
	// 为上传文件做准备，找地址
	private ServletContext servletContext;

	@Override
	public void setServletContext(ServletContext context) {
		this.servletContext = context;
	}

	@Autowired
	ManagerService managerService;

	// 管理员列表页面跳转
	@RequestMapping("/getManagers")
	public ModelAndView getManagers() {
		ModelAndView modelAndView = new ModelAndView("back/manager");
		return modelAndView;
	}

	// 管理员列表数据
	@RequestMapping("/getManagerList")
	@ResponseBody
	public ModelMap getManagerList(HttpServletRequest request) {
		ModelMap modelMap = new ModelMap();
		Manager model = new Manager();
		// 获取页面传来的参数
		String name = request.getParameter("name");
		// 设置参数值
		model.setName(name);
		// 当前页码
		String currpage = request.getParameter("currpage");
		// 页面显示记录条数
		String pageSize = request.getParameter("pageSize");
		if (currpage != null && pageSize != null & !currpage.equals("") && !pageSize.equals("")) {
			PageHelper.startPage(Integer.parseInt(currpage), Integer.parseInt(pageSize));
		}
		// model.setId(1);
		// Manager info=new Manager();
		// String id=request.getParameter("id");
		// int id1 = Integer.parseInt(id);//强转
		// managerService.deleteById(3);
		List<Manager> list = managerService.getManagers(model);
		PageInfo page = new PageInfo(list);
		modelMap.addAttribute("page", page);
		// 问题： 我调试了，步骤四中的list是一个ArrayList，
		// 所以报错（java.util.ArrayList cannot be cast to
		// com.github.pagehelper.Page）。
		// 分析的没错应该是上面加的maven和plugins有问题导致list没有变成Page类型，然后在强制转换报错了
		// modelMap.addAttribute("row", (int)((Page)list).getTotal());
		return modelMap;
	}

	// delete删除
	@RequestMapping("/delete")
	@ResponseBody
	public ModelMap delete(HttpServletRequest request) {
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
			managerService.deleteById(id);
		}
		return modelMap;
	}

	// add添加，页面跳转
	@RequestMapping("/addView")
	public ModelAndView addView() {
		ModelAndView modelAndView = new ModelAndView("back/managerAdd");
		return modelAndView;
	}

	// add添加
	@RequestMapping("/add")
	@ResponseBody
	public ModelAndView add(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView("back/manager");
		// 1.得到服务器地址
		String path = this.servletContext.getRealPath("/tmp/");
		// System.out.println("path——————————————————————"+path);
		// ModelMap modelMap =new ModelMap();
		try {
			Manager model = new Manager();
			String name = request.getParameter("name");
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
			model.setName(name);
			managerService.save(model);
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
	@RequestMapping("/editView")
	public ModelAndView editView(HttpServletRequest request) {
		String id = request.getParameter("id");
		Manager model = new Manager();
		model.setId(Integer.parseInt(id));
		List<Manager> list = managerService.getManagers(model);
		ModelAndView modelAndView = new ModelAndView("back/managerEdit");
		modelAndView.addObject("info", list.get(0));
		return modelAndView;
	}

	// edit编辑
	@RequestMapping("/update")
	@ResponseBody
	public ModelMap update(HttpServletRequest request) {
		ModelMap modelMap = new ModelMap();
		try {
			Manager model = new Manager();
			String id = request.getParameter("id");
			String name = request.getParameter("name");
			String password = request.getParameter("password");
			model.setId(Integer.parseInt(id));
			model.setName(name);
			model.setPassword(password);
			managerService.update(model);
			modelMap.addAttribute("success", Boolean.TRUE);
		} catch (Exception ex) {
			modelMap.addAttribute("success", Boolean.FALSE);
		}
		return modelMap;
	}

}
