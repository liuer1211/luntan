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
import com.forum.service.ArgumentService;
import com.forum.service.CommentService;
import com.forum.service.UserService;

@Controller
@RequestMapping("/comment")
public class CommentController {
	@Autowired
	public ArgumentService argumentService;
	@Autowired
	public UserService userService;
	@Autowired
	public CommentService commentService;
	
	//跳转+参数传递+列表展示
	@RequestMapping("/commentStart")
	public ModelAndView getCommentStart(HttpServletRequest request){
		ModelAndView modelAndView=new ModelAndView("front/comment");
		ModelAndView modelAndView1=new ModelAndView("front/login");
		//言论表的id
		String id=request.getParameter("id");
		Argument model=new Argument();
		model.setId(Integer.parseInt(id));
		//根据言论表id，查询言论的详细信息
		List<Argument> argumentOne = argumentService.getArguments(model);
		if(argumentOne.size()>0){
			//查询argument,后获取，传到页面
			request.setAttribute("argumentOne", argumentOne.get(0));
			//查询argument和comment
			Comment modelComment=new Comment();
			modelComment.setArgumentId(Integer.parseInt(id));
			List<Comment> commentList = commentService.getComments(modelComment);
			request.setAttribute("commentList", commentList);
			
			return modelAndView;
		}else{
			return modelAndView1;
		}
	}
	
	@RequestMapping("/commentSave")
	public String commentSave(HttpServletRequest request) {
//		ModelAndView modelAndView1 = new ModelAndView("front/success");
//		ModelAndView modelAndView2 = new ModelAndView("front/argumentStart");
		String argumentId = request.getParameter("argumentId");
		String userId = request.getParameter("userId");
		String content = request.getParameter("content");
		Comment model = new Comment();
		if (!"".equals(userId)) {
			model.setArgumentId(Integer.parseInt(argumentId));
			model.setUserId(Integer.parseInt(userId));
			model.setContent(content);
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
			model.setDateTimes(df.format(new Date()));
			// 添加
			boolean bool = commentService.commentSave(model);
			if (bool == true) {
				return "redirect:/index.jsp";
			} else {
				return "front/login";
			}
		} else {
			return "front/login";
		}
	}
	
	
}
