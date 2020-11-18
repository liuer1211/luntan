package com.forum.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
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
import com.forum.util.Md5;
import com.forum.util.PageUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

public class A {

	// index网站首页跳转
	@RequestMapping("/indexStart")
	public void indexView(HttpServletResponse response, HttpServletRequest request)
			throws IOException, ServletException {
		Information Information = new Information();
		List<Information> listInformation = informationService.getInformations(Information);
		request.setAttribute("list", listInformation);
		request.getRequestDispatcher("/index.jsp").forward(request, response);
	}

	@Autowired
	ManagerService managerService;
	@Autowired
	private HttpSession session;

	@RequestMapping("/login")
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws IOException {
		ModelAndView modelAndView1 = new ModelAndView("back/backspage");
		ModelAndView modelAndView2 = new ModelAndView("back/login");
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		if (name != null && password != null) {
			Manager model = new Manager();
			model.setName(name);
			model.setPassword(password);
			List<Manager> manager = managerService.getManagers(model);
			if (manager.size() > 0) {
				session.setAttribute("manager", manager.get(0));
				return modelAndView1;
			} else {
				String error = "用户名或密码错误";
				request.setAttribute("error", error);
				return modelAndView2;
			}
		} else {
			return modelAndView2;
		}
	}// 用户的

	@Autowired
	public UserService userService;

	@RequestMapping("/register")
	public ModelAndView register(HttpServletRequest request, HttpSession session) {
		ModelAndView modelView = new ModelAndView("front/success");
		ModelAndView modelAndView2 = new ModelAndView("front/register");
		User model = new User();
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String mobile = request.getParameter("mobile");
		String nameCheck = request.getParameter("nameCheck");
		String code = request.getParameter("code");
		String upperCode = "";
		if (code != null) {
			upperCode = code.toUpperCase();
		}
		if (name != null && password != null && email != null && mobile != null) {
			if (nameCheck.equals("nameCheck")) {
				String codes = (String) session.getAttribute("code");
				if (codes.equals(upperCode)) {
					model.setName(name);
					password = Md5.md5(password);
					model.setPassword(password);
					model.setEmail(email);
					model.setMobile(mobile);
					SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
					model.setRegisterDate(df.format(new Date()));
					model.setPicture("20180422141151.jpg");
					userService.save(model);
					return modelView;
				} else {
					String codeError = "验证码有误！";
					request.setAttribute("codeError", codeError);
					return modelAndView2;
				}
			} else {
				return modelAndView2;
			}
		} else {
			return modelAndView2;
		}
	}

	@RequestMapping("/checkUser")
	@ResponseBody
	public ModelMap checkUser(HttpServletRequest request) {
		ModelMap modelMap = new ModelMap();
		String name = request.getParameter("name");
		if (name == null) {
			modelMap.addAttribute("success", "error");
		} else {
			if (name.length() > 1 && name.length() < 17) {
				User model = new User();
				model.setName(name);
				List<User> list = userService.getUserInfo(model);
				if (list.size() > 0) {
					modelMap.addAttribute("success", Boolean.FALSE);
				} else {
					modelMap.addAttribute("success", Boolean.TRUE);
				}
			} else {
				modelMap.addAttribute("success", "error");
			}
		}
		return modelMap;
	}

	// 新闻的
	@Autowired
	public InformationService informationService;
	// 言论的
	@Autowired
	public ArgumentService argumentService;

	// 用户登录
	@RequestMapping("/login")
	public String login(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws UnsupportedEncodingException {
		User model = new User();
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String remember = request.getParameter("remember");
		if (name != null && password != null) {
			if ("true".equals(remember)) {
				String nameUrl = URLEncoder.encode(name, "utf-8");
				Cookie cookieName = new Cookie("COOKIENAME", nameUrl);
				cookieName.setMaxAge(7 * 24 * 3600);
				response.addCookie(cookieName);
				String passwordUrl = URLEncoder.encode(password, "utf-8");
				Cookie cookiePassword = new Cookie("COOKIPASSWORD", passwordUrl);
				cookiePassword.setMaxAge(7 * 24 * 3600);
				response.addCookie(cookiePassword);
			} else {
				String nameUrl = URLEncoder.encode(name, "utf-8");
				Cookie cookieName = new Cookie("COOKIENAME", nameUrl);
				cookieName.setMaxAge(0);
				response.addCookie(cookieName);
				String passwordUrl = URLEncoder.encode(password, "utf-8");
				Cookie cookiePassword = new Cookie("COOKIPASSWORD", passwordUrl);
				cookiePassword.setMaxAge(0);
				response.addCookie(cookiePassword);
			}
			password = Md5.md5(password);
			model.setName(name);
			model.setPassword(password);
			List<User> list = userService.getUserOne(model);
			if (list.size() > 0) {
				Integer id = list.get(0).getId();
				model.setId(id);
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				model.setLoginDate(df.format(new Date()));
				userService.update(model);
				Information Information = new Information();
				List<Information> listInformation = informationService.getInformations(Information);
				request.setAttribute("list", listInformation);
				session.setAttribute("user", list.get(0));
				return "forward:/index.jsp";
			} else {
				String error = "用户名或密码错误";
				request.setAttribute("error", error);
				return "front/login";
			}
		} else {
			return "front/login";
		}
	}

	// 退出登录
	@RequestMapping("/loginOut")
	public ModelAndView loginOut(HttpSession session) {
		ModelAndView modelAndView = new ModelAndView("front/login");
		if (session != null) {
			// 销毁
			session.invalidate();
		}
		return modelAndView;
	}

	// 个人中心
	@RequestMapping("/userInfo")
	public ModelAndView getUsersInfo(HttpSession session, HttpServletRequest request) {
		ModelAndView modelAndView1 = new ModelAndView("front/main");
		ModelAndView modelAndView2 = new ModelAndView("front/login");
		User userOne = new User();
		String id = request.getParameter("id");
		if (!"".equals(id)) {
			userOne.setId(Integer.parseInt(id));
			List<User> listOne = userService.getUsers(userOne);
			User model = new User();
			List<User> listUser = userService.getUserLoginDate(model);
			Argument argument = new Argument();
			argument.setUserId(Integer.parseInt(id));
			List<Argument> listArgumentOnes = argumentService.getArguments(argument);
			if (listOne.size() > 0) {
				request.setAttribute("userOne", listOne.get(0));
				request.setAttribute("userList", listUser);
				request.setAttribute("listArgumentOnes", listArgumentOnes);
				return modelAndView1;
			} else {
				return modelAndView2;
			}
		} else {
			return modelAndView2;
		}
	}

	@RequestMapping(value = "/userUpdate/{id}")
	public ModelAndView userUpdate(HttpServletRequest request, @PathVariable("id") Integer id) {
		ModelAndView modelAndView1 = new ModelAndView("front/userUpdate");
		ModelAndView modelAndView2 = new ModelAndView("front/userUpdate");
		User model = new User();
		model.setId(id);
		List<User> listOne = userService.getUsers(model);
		if (listOne.size() > 0) {
			request.setAttribute("listOne", listOne.get(0));
			return modelAndView1;
		} else {
			return modelAndView2;
		}
	}// 为上传文件做准备，找地址

	private ServletContext servletContext;

	// @Override
	// public void setServletContext(ServletContext context) {
	// this.servletContext = context;
	// }
	// 论坛
	@RequestMapping("/tribuneStart")
	public ModelAndView getTribuneView(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView("front/tribune");
		Argument model = new Argument();
		String page = request.getParameter("page");
		int size = 6;
		int offset = PageUtil.offset(page, size);
		model.setOffset(offset);
		model.setSize(size);
		List<Argument> list = argumentService.getArgumentPage(model);
		modelAndView.addObject("list", list);
		int count = argumentService.getCount();
		modelAndView.addObject("count", count);
		request.setAttribute("currentPage", PageUtil.currentPage(page));
		request.setAttribute("totalPage", PageUtil.totalPage(count, size));
		return modelAndView;
	}

	@Autowired
	public AlbumService albumService;

	@RequestMapping("/albumStart")
	public ModelAndView getAlbumView(HttpServletRequest request) {
		ModelAndView modelAndView1 = new ModelAndView("front/album");
		ModelAndView modelAndView2 = new ModelAndView("front/login");
		String id = request.getParameter("id");
		Album model = new Album();
		if (!"".equals(id)) {
			model.setUserId(Integer.parseInt(id));
			List<Album> listOne = albumService.getAlbums(model);
			if (listOne.size() > 0) {
				request.setAttribute("listOne", listOne);
				return modelAndView1;
			} else {
				request.setAttribute("listOne", listOne);
				return modelAndView1;
			}
		} else {
			return modelAndView2;
		}
	}

	@Autowired
	public PhotoService photoService;

	@RequestMapping("/photoStart")
	public ModelAndView getPhotoView(HttpServletRequest request) {
		ModelAndView modelAndView1 = new ModelAndView("front/photo");
		ModelAndView modelAndView2 = new ModelAndView("front/photo");
		String albumId = request.getParameter("albumId");
		Photo model = new Photo();
		model.setAlbumId(Integer.parseInt(albumId));
		List<Photo> list = photoService.getPhotos(model);
		if (list.size() > 0) {
			request.setAttribute("list", list);
			request.setAttribute("listAlbumId", albumId);
			return modelAndView1;
		} else {
			request.setAttribute("listAlbumId", albumId);
			return modelAndView1;
		}
	}

	@Autowired
	public PhotoCommentService photoCommentService;

	// 跳转：分页查询
	@RequestMapping("/informationStart")
	public ModelAndView getImformationView(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView("front/information");
		Information model = new Information();
		String page = request.getParameter("page");
		int size = 5;
		int offset = PageUtil.offset(page, size);
		model.setOffset(offset);
		model.setSize(size);
		List<Information> list = informationService.getInformationPage(model);
		modelAndView.addObject("list", list);
		int count = informationService.getCount();
		modelAndView.addObject("count", count);
		request.setAttribute("currentPage", PageUtil.currentPage(page));
		request.setAttribute("totalPage", PageUtil.totalPage(count, size));
		return modelAndView;
	}

	// 添加图片
	@RequestMapping("/photoSave")
	public ModelAndView photoSave(HttpServletRequest request) {
		ModelAndView modelAndView1 = new ModelAndView("front/success");
		String albumId = request.getParameter("albumId");
		String path = this.servletContext.getRealPath("/tmp/");
		MultipartHttpServletRequest mrep = (MultipartHttpServletRequest) request;
		MultipartFile file = mrep.getFile("picture");
		Photo model = new Photo();
		model.setAlbumId(Integer.parseInt(albumId));
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		model.setCreateDate(sdf1.format(new Date()));
		try {
			String fileName = file.getOriginalFilename();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String newfile = sdf.format(new Date()) + fileName.substring(fileName.lastIndexOf('.'));
			FileOutputStream fos = new FileOutputStream(path + newfile);
			fos.write(file.getBytes());
			fos.flush();
			fos.close();
			model.setPicture(newfile);
			photoService.photoSave(model);
		} catch (Exception e) {
		}
		return modelAndView1;
	}

	// 添加评论
	@RequestMapping("/photoCommentSave")
	public ModelAndView photoCommentSave(HttpServletRequest request) {
		ModelAndView modelAndView1 = new ModelAndView("front/success");
		ModelAndView modelAndView2 = new ModelAndView("front/login");
		String photoId = request.getParameter("photoId");
		String userId = request.getParameter("userId");
		String content = request.getParameter("content");
		PhotoComment model = new PhotoComment();
		if (!"".equals(userId)) {
			model.setPhotoId(Integer.parseInt(photoId));
			model.setUserId(Integer.parseInt(userId));
			model.setContent(content);
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
			model.setCommentDate(df.format(new Date()));
			boolean bool = photoCommentService.photoCommentSave(model);
			if (bool == true) {
				return modelAndView1;
			} else {
				return modelAndView2;
			}
		} else {
			return modelAndView2;
		}
	}

	@RequestMapping("/albumSave")
	public ModelAndView albumSave(HttpServletRequest request) {
		ModelAndView modelAndView1 = new ModelAndView("front/success");
		ModelAndView modelAndView2 = new ModelAndView("front/login");
		String userId = request.getParameter("userId");
		String title = request.getParameter("title");
		String path = this.servletContext.getRealPath("/tmp/");
		MultipartHttpServletRequest mrep = (MultipartHttpServletRequest) request;
		MultipartFile file = mrep.getFile("picture");
		Album model = new Album();
		if (!"".equals(userId)) {
			model.setUserId(Integer.parseInt(userId));
			model.setTitle(title);
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			model.setCreateDate(sdf1.format(new Date()));
			model.setPicture("xc.jpg");
			albumService.albumSave(model);
			try {
				String fileName = file.getOriginalFilename();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				String newfile = sdf.format(new Date()) + fileName.substring(fileName.lastIndexOf('.'));
				FileOutputStream fos = new FileOutputStream(path + newfile);
				fos.write(file.getBytes());
				fos.flush();
				fos.close();
				model.setPicture(newfile);
				albumService.albumSave(model);
			} catch (Exception e) {
			}
			return modelAndView1;
		} else {
			return modelAndView2;
		}
	}

	// 提交编写的论点
	@RequestMapping("/argumentSave")
	public ModelAndView argumentSave(HttpServletRequest request) {
		ModelAndView modelAndView1 = new ModelAndView("front/success");
		ModelAndView modelAndView2 = new ModelAndView("front/argumentStart");
		String userId = request.getParameter("userId");
		String property = request.getParameter("property");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		Argument model = new Argument();
		model.setUserId(Integer.parseInt(userId));
		model.setProperty(property);
		model.setTitle(title);
		model.setContent(content);
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
		model.setPublishTime(df.format(new Date()));
		boolean bool = argumentService.argumentSave(model);
		if (bool == true) {
			return modelAndView1;
		} else {
			return modelAndView2;
		}
	}

	// 修改密码-参数操作
	@RequestMapping("/userEditPass")
	public ModelAndView userEditPass(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView("/front/success2");
		ModelAndView modelAndView1 = new ModelAndView("/front/userEditPassView");
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		User model = new User();
		password = Md5.md5(password);
		model.setId(Integer.parseInt(id));
		model.setPassword(password);
		boolean bool = userService.update(model);
		if (bool == true) {
			return modelAndView;
		} else {
			return modelAndView1;
		}
	}

	// 用户修改
	@RequestMapping("/userEdit")
	public ModelAndView userEdit(HttpServletRequest request) {
		ModelAndView modelAndView1 = new ModelAndView("front/success1");
		String path = this.servletContext.getRealPath("/tmp/");
		MultipartHttpServletRequest mreq = (MultipartHttpServletRequest) request;
		MultipartFile file = mreq.getFile("picture");
		User model = new User();
		String id = request.getParameter("id");
		String gender = request.getParameter("gender");
		String email = request.getParameter("email");
		String mobile = request.getParameter("mobile");
		String address = request.getParameter("address");
		String birthday = request.getParameter("birthday");
		String describes = request.getParameter("describes");
		model.setId(Integer.parseInt(id));
		model.setGender(gender);
		model.setEmail(email);
		model.setMobile(mobile);
		model.setAddress(address);
		model.setBirthday(birthday);
		model.setDescribes(describes);
		boolean b = userService.update(model);
		try {
			String fileName = file.getOriginalFilename();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String newfile = sdf.format(new Date()) + fileName.substring(fileName.lastIndexOf('.'));
			FileOutputStream fos = new FileOutputStream(path + newfile);
			fos.write(file.getBytes());
			fos.flush();
			fos.close();
			model.setPicture(newfile);
			userService.update(model);
		} catch (Exception e) {
		}
		return modelAndView1;
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
		List<Manager> list = managerService.getManagers(model);
		PageInfo page = new PageInfo(list);
		modelMap.addAttribute("page", page);
		return modelMap;
	}

	// 用户列表数据
	@RequestMapping("/getArgumentList")
	@ResponseBody
	public ModelMap getArgumentList(HttpServletRequest request) {
		ModelMap modelMap = new ModelMap();
		Argument model = new Argument();
		String title = request.getParameter("title");
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String property = request.getParameter("property");
		model.setTitle(title);
		model.setStartdate(startdate);
		model.setEnddate(enddate);
		model.setProperty(property);
		String currpage = request.getParameter("currpage");
		String pageSize = request.getParameter("pageSize");
		if (currpage != null && pageSize != null & !currpage.equals("") && !pageSize.equals("")) {
			PageHelper.startPage(Integer.parseInt(currpage), Integer.parseInt(pageSize));
		}
		List<Argument> list = argumentService.getArguments(model);
		PageInfo page = new PageInfo(list);
		modelMap.addAttribute("page", page);
		return modelMap;
	}

	// 用户列表数据
	@RequestMapping("/getUserList")
	@ResponseBody
	public ModelMap getUserList(HttpServletRequest request) {
		ModelMap modelMap = new ModelMap();
		User model = new User();
		String name = request.getParameter("name");
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String gender = request.getParameter("gender");
		model.setName(name);
		model.setStartdate(startdate);
		model.setEnddate(enddate);
		model.setGender(gender);
		String currpage = request.getParameter("currpage");
		String pageSize = request.getParameter("pageSize");
		if (currpage != null && pageSize != null & !currpage.equals("") && !pageSize.equals("")) {
			PageHelper.startPage(Integer.parseInt(currpage), Integer.parseInt(pageSize));
		}
		List<User> list = userService.getUsers(model);
		PageInfo page = new PageInfo(list);
		modelMap.addAttribute("page", page);
		return modelMap;
	}

	// 登录 跳转页面 + 到参数
	@RequestMapping("/login")
	public ModelAndView backLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
		ModelAndView modelAndView1 = new ModelAndView("back/backspage");
		ModelAndView modelAndView2 = new ModelAndView("back/login");
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		if (name != null && password != null) {
			Manager model = new Manager();
			model.setName(name);
			model.setPassword(password);
			List<Manager> manager = managerService.getManagers(model);
			if (manager.size() > 0) {
				session.setAttribute("manager", manager.get(0));
				return modelAndView1;
			} else {
				String error = "用户名或密码错误";
				request.setAttribute("error", error);
				return modelAndView2;
			}
		} else {
			return modelAndView2;
		}
	}

	@Autowired
	CommentService commentService;

	// 评论列表数据
	@RequestMapping("/getCommentList")
	@ResponseBody
	public ModelMap getCommentList(HttpServletRequest request) {
		ModelMap modelMap = new ModelMap();
		Comment model = new Comment();
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		model.setStartdate(startdate);
		model.setEnddate(enddate);
		String currpage = request.getParameter("currpage");
		String pageSize = request.getParameter("pageSize");
		if (currpage != null && pageSize != null & !currpage.equals("") && !pageSize.equals("")) {
			PageHelper.startPage(Integer.parseInt(currpage), Integer.parseInt(pageSize));
		}
		List<Comment> list = commentService.getComments(model);
		PageInfo page = new PageInfo(list);
		modelMap.addAttribute("page", page);
		return modelMap;
	}

	// 用户列表数据
	@RequestMapping("/getAlbumList")
	@ResponseBody
	public ModelMap getAlbumList(HttpServletRequest request) {
		ModelMap modelMap = new ModelMap();
		Album model = new Album();
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String title = request.getParameter("title");
		model.setStartdate(startdate);
		model.setEnddate(enddate);
		model.setTitle(title);
		String currpage = request.getParameter("currpage");
		String pageSize = request.getParameter("pageSize");
		if (currpage != null && pageSize != null & !currpage.equals("") && !pageSize.equals("")) {
			PageHelper.startPage(Integer.parseInt(currpage), Integer.parseInt(pageSize));
		}
		List<Album> list = albumService.getAlbums(model);
		PageInfo page = new PageInfo(list);
		modelMap.addAttribute("page", page);
		return modelMap;
	}

	// 用户列表数据
	@RequestMapping("/getPhotoCommentList")
	@ResponseBody
	public ModelMap getPhotoCommentList(HttpServletRequest request) {
		ModelMap modelMap = new ModelMap();
		PhotoComment model = new PhotoComment();
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		model.setStartdate(startdate);
		model.setEnddate(enddate);
		String currpage = request.getParameter("currpage");
		String pageSize = request.getParameter("pageSize");
		if (currpage != null && pageSize != null & !currpage.equals("") && !pageSize.equals("")) {
			PageHelper.startPage(Integer.parseInt(currpage), Integer.parseInt(pageSize));
		}
		List<PhotoComment> list = photoCommentService.getPhotoComments(model);
		PageInfo page = new PageInfo(list);
		modelMap.addAttribute("page", page);
		return modelMap;
	}

	// 用户列表数据
	@RequestMapping("/getInformationList")
	@ResponseBody
	public ModelMap getInformationList(HttpServletRequest request) {
		ModelMap modelMap = new ModelMap();
		Information model = new Information();
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String title = request.getParameter("title");
		model.setStartdate(startdate);
		model.setEnddate(enddate);
		model.setTitle(title);
		;
		String currpage = request.getParameter("currpage");
		String pageSize = request.getParameter("pageSize");
		if (currpage != null && pageSize != null & !currpage.equals("") && !pageSize.equals("")) {
			PageHelper.startPage(Integer.parseInt(currpage), Integer.parseInt(pageSize));
		}
		List<Information> list = informationService.getInformations(model);
		PageInfo page = new PageInfo(list);
		modelMap.addAttribute("page", page);
		return modelMap;
	}

	// 用户列表数据
	@RequestMapping("/getPhotoList")
	@ResponseBody
	public ModelMap getPhotoList(HttpServletRequest request) {
		ModelMap modelMap = new ModelMap();
		Photo model = new Photo();
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		model.setStartdate(startdate);
		model.setEnddate(enddate);
		String currpage = request.getParameter("currpage");
		String pageSize = request.getParameter("pageSize");
		if (currpage != null && pageSize != null & !currpage.equals("") && !pageSize.equals("")) {
			PageHelper.startPage(Integer.parseInt(currpage), Integer.parseInt(pageSize));
		}
		List<Photo> list = photoService.getPhotos(model);
		PageInfo page = new PageInfo(list);
		modelMap.addAttribute("page", page);
		return modelMap;
	}

	@RequestMapping("/informationAdd")
	@ResponseBody
	public ModelAndView add(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView("back/information");
		String path = this.servletContext.getRealPath("/tmp/");
		try {
			Information model = new Information();
			String title = request.getParameter("title");
			String link = request.getParameter("link");
			String content = request.getParameter("content");
			MultipartHttpServletRequest mreq = (MultipartHttpServletRequest) request;
			MultipartFile file = mreq.getFile("picture");
			String fileName = file.getOriginalFilename();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String newfile = sdf.format(new Date()) + fileName.substring(fileName.lastIndexOf('.'));
			FileOutputStream fos = new FileOutputStream(path + newfile);
			fos.write(file.getBytes());
			fos.flush();
			fos.close();
			model.setPicture(newfile);
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
			model.setDateTimes(df.format(new Date()));
			model.setTitle(title);
			model.setLink(link);
			model.setContent(content);
			informationService.save(model);
		} catch (Exception ex) {
		}
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
			String title = request.getParameter("title");
			String link = request.getParameter("link");
			String content = request.getParameter("content");
			model.setId(Integer.parseInt(id));
			model.setTitle(title);
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
