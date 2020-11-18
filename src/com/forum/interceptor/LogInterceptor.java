package com.forum.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.forum.pojo.Manager;

public class LogInterceptor implements HandlerInterceptor{
	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
	}
	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
	}
	//登录   拦截    加权限
	//true：继续调用后续的拦截器和目标方法
	//false：不继续调用后续的拦截器和目标方法
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
		HttpSession session=request.getSession();
		Manager manager=(Manager) session.getAttribute("manager");
		//System.out.println("---****--"+manager);
		// "" 里加登录  URL
		
		//1、请求到登录页面 放行  
//	    if(request.getServletPath().startsWith("")) {  
//	        return true;  
//	    } 
		
	    //2、如果用户已经登录 放行   
		if(manager!=null){
			//不为空  方行
			return true;
		}
		
		//3、非法请求 即这些请求需要登录后才能访问  
	    //重定向到登录页面 
		response.sendRedirect(request.getContextPath() + "/back/login");  
		
//		response.sendRedirect("/main.jsp");
//		response.sendRedirect("/pages/back/login.jsp");
//		response.sendRedirect(request.getContextPath()+"/back/login.jsp");
//		System.out.println("*****"+request.getContextPath());
//		request.getRequestDispatcher("/back/login.jsp").forward(request, response);
		return false;
	}
	
}
