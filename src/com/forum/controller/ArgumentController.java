package com.forum.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.forum.pojo.Argument;
import com.forum.pojo.Comment;
import com.forum.pojo.User;
import com.forum.service.ArgumentService;
import com.forum.service.CommentService;
import com.forum.service.UserService;
import com.forum.util.PageUtil;

@Controller
@RequestMapping("/argument")
public class ArgumentController {
	@Autowired
	public ArgumentService argumentService;
	@Autowired
	public UserService userService;

	// 论坛
	@RequestMapping("/tribuneStart")
	public ModelAndView getTribuneView(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView("front/tribune");
		Argument model = new Argument();
		// List<Argument> list=argumentService.getArguments(model);
		// modelAndView.addObject("list", list);
		// System.out.println("----------------------"+count);
		// 获得page，如果page=0，工具类里有判断处理
		String page = request.getParameter("page");
		int size = 6;
		int offset = PageUtil.offset(page, size);
		model.setOffset(offset);
		model.setSize(size);
		// 分页显示
		List<Argument> list = argumentService.getArgumentPage(model);
		modelAndView.addObject("list", list);
		// 总记录数
		int count = argumentService.getCount();
		modelAndView.addObject("count", count);
		// 当前页
		request.setAttribute("currentPage", PageUtil.currentPage(page));
		// 总页数
		request.setAttribute("totalPage", PageUtil.totalPage(count, size));
		return modelAndView;
	}

	// 编写论点,先跳转，把用户id带上，然后传到页面中
	@RequestMapping("/argumentStart")
	public ModelAndView getArgumentView(HttpServletRequest request) {
		ModelAndView modelAndView1 = new ModelAndView("front/argument");
		ModelAndView modelAndView2 = new ModelAndView("front/login");
		// 用户的id，对应言论表userID
		String id = request.getParameter("id");
		User model = new User();
		// id不为空才能跳转（去发表）
		if (!"".equals(id)) {
			// 查询是否有该用户
			model.setId(Integer.parseInt(id));
			List<User> list = userService.getUsers(model);
			if (list.size() > 0) {
				// 找到该用户，设置数据，前台得到，隐藏起来，
				request.setAttribute("list", list.get(0));
				return modelAndView1;
			} else {
				return modelAndView2;
			}
		} else {
			return modelAndView2;
		}
	}

	// 提交编写的论点
	@RequestMapping("/argumentSave")
	public String argumentSave(HttpServletRequest request) {
//		ModelAndView modelAndView1 = new ModelAndView("front/success");
//		ModelAndView modelAndView2 = new ModelAndView("front/argumentStart");
		// 获得参数
		String userId = request.getParameter("userId");
		String property = request.getParameter("property");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		// 设置参数
		Argument model = new Argument();
		model.setUserId(Integer.parseInt(userId));
		model.setProperty(property);
		model.setTitle(title);
		model.setContent(content);
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
		model.setPublishTime(df.format(new Date()));
		// 添加
		boolean bool = argumentService.argumentSave(model);
		// 判断是否添加成功
		if (bool == true) {
			return "redirect:/index.jsp";
		} else {
			return "front/login";
		}
	}
	
	
}
