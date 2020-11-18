package com.forum.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.forum.pojo.Manager;
import com.forum.service.ManagerService;

@Controller
@RequestMapping("/back")
public class BackController {
	@Autowired
	ManagerService managerService;
	
	@Autowired
	private HttpSession session;

	// 后台管理页面
	@RequestMapping("/view")
	public ModelAndView getView() {
		ModelAndView modelAndView = new ModelAndView("back/backspage");
		return modelAndView;
	}

	// 后台欢迎页面
	@RequestMapping("/welcome")
	public ModelAndView member() {
		ModelAndView modelAndView = new ModelAndView("back/welcome");
		return modelAndView;
	}

	// 导航 登录 跳转
	@RequestMapping("/loginStart")
	public String loginStart() {
		return "back/login";
	}

	// 登录 跳转页面 + 到参数
	@RequestMapping("/login")
	public ModelAndView backLogin(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		/*
		 * 也可以使用 返回String
		 * 
		 * 问题：1.登录成功 跳转 页面出现乱码
		 */
		ModelAndView modelAndView1 = new ModelAndView("back/backspage");
		ModelAndView modelAndView2 = new ModelAndView("back/login");
		// PrintWriter out = response.getWriter();

		String name = request.getParameter("name");
		String password = request.getParameter("password");
		// name 为空 可能查到 并且查到的是所有，所以要先做限制
		//这里有点类似于过滤器
		//当输入的网址是view的而不是login，后台保存到request里了；登录是保存到session里了
		if (name != null && password != null) {
			Manager model = new Manager();
			model.setName(name);
			model.setPassword(password);
//			 在登录页面为时有jquery判断，所以不担心
			List<Manager> manager = managerService.getManagers(model);
			// 判断的时候不能用 list.get(0)!=null 因为，name是模糊查询，有时不为空，但是密码错误，会出错。
			
//			System.out.println("---------"+manager.size());
			
			if (manager.size() > 0) {
				// System.out.println("--------------------"+manager);
				// 注意：不能直接map.put("manager", manager);这样manager的值，不能指到实体类
				session.setAttribute("manager", manager.get(0));
//				System.out.println("---*****-----:" + manager.get(0).getName());
//				System.out.println("---*****-----:" + manager.get(0).getPassword());
				
//				for (Manager manager2 : manager) {
//					System.out.println("*****"+manager2.getName());
//				}
				
				return modelAndView1;
			} else {
				String error = "用户名或密码错误";
				request.setAttribute("error", error);
				return modelAndView2;
			}
		}else{
			//为空直接  跳到登录页面，不为空进行一系列的判断
			//这里不能提示，因为跳到这个页面时啥都没写   你可以加提示
			//另外，防止输入 URL  直接显示错误提示
//			String error = "用户名或密码错误";
//			request.setAttribute("error", error);
			return modelAndView2;
		}
	}

	// 退出登录
	@RequestMapping("/loginOut")
	public ModelAndView loginOut() {
		ModelAndView modelAndView = new ModelAndView("back/login");
		if(session!=null){
//			System.out.println("-*---"+session.getAttribute("manager"));
//			session.removeAttribute("manager");
//			System.out.println("--+--"+session.getAttribute("manager"));
			session.invalidate();
//			System.out.println("--/--"+session.getAttribute("manager"));
//			----com.forum.pojo.Manager@5594cde9
//			----null
//			----null
		}
		return modelAndView;
	}

}
