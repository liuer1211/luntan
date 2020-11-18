package com.forum.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.forum.pojo.Information;
import com.forum.service.InformationService;

@Controller
@RequestMapping("/front")
public class FrontController {
	//新闻的
	@Autowired
	public InformationService informationService;
	
	//注册跳转
	@RequestMapping("/registerStart")
	public ModelAndView registerView() {
		ModelAndView modelAndView=new ModelAndView("front/register");
		return modelAndView;
	}
	//登录跳转
	@RequestMapping("/loginStart")
	public ModelAndView loginView() {
		ModelAndView modelAndView=new ModelAndView("front/login");
		return modelAndView;
	}
	//index网站首页跳转
	@RequestMapping("/indexStart")
	public void indexView(HttpServletResponse response,HttpServletRequest request) 
			throws IOException, ServletException {
		Information Information=new Information();	
		List<Information> listInformation = informationService.getInformations(Information);
		request.setAttribute("list", listInformation);
		//response.sendRedirect(request.getContextPath() +"/index.jsp");
		request.getRequestDispatcher("/index.jsp").forward(request, response);
	}
	
}
