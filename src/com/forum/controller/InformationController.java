package com.forum.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.forum.pojo.Argument;
import com.forum.pojo.Information;
import com.forum.service.InformationService;
import com.forum.util.PageUtil;

@Controller
@RequestMapping("/information")
public class InformationController {
	@Autowired
	public InformationService informationService;
	
	//跳转：分页查询
	@RequestMapping("/informationStart")
	public ModelAndView getImformationView(HttpServletRequest request){
		ModelAndView modelAndView =new ModelAndView("front/information");
		Information model=new Information();
		//获得page，如果page=0，工具类里有判断处理
		String page = request.getParameter("page");
		int size=5;
		int offset = PageUtil.offset(page,size);
		model.setOffset(offset);
		model.setSize(size);
		//分页显示
		List<Information> list=informationService.getInformationPage(model);
		modelAndView.addObject("list", list);
		//总记录数
		int count=informationService.getCount();
		modelAndView.addObject("count", count);
		//当前页
		request.setAttribute("currentPage", PageUtil.currentPage(page));
		//总页数
		request.setAttribute("totalPage", PageUtil.totalPage(count, size));
		return modelAndView;
	}
	
	
	
}
