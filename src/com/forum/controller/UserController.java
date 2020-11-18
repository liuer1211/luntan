package com.forum.controller;

import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.forum.pojo.Album;
import com.forum.pojo.Argument;
import com.forum.pojo.Information;
import com.forum.pojo.User;
import com.forum.service.AlbumService;
import com.forum.service.ArgumentService;
import com.forum.service.InformationService;
import com.forum.service.UserService;
import com.forum.util.Md5;
import com.forum.util.PageUtil;

@Controller
@RequestMapping("/user")
public class UserController implements ServletContextAware {
	// 为上传文件做准备，找地址
	private ServletContext servletContext;

	@Override
	public void setServletContext(ServletContext context) {
		this.servletContext = context;
	}

	// 用户的
	@Autowired
	public UserService userService;
	// 新闻的
	@Autowired
	public InformationService informationService;
	// 言论的
	@Autowired
	public ArgumentService argumentService;
	//相册的
	@Autowired
	public AlbumService albumService;

	// 用户注册 用户名唯一性
	@RequestMapping("/checkUser")
	@ResponseBody
	public ModelMap checkUser(HttpServletRequest request) {
		ModelMap modelMap = new ModelMap();
		String name = request.getParameter("name");
		// System.out.println("----------"+name);
		// System.out.println(name.length());
		/*
		 * name.matches(name); 方法判断：返回true，false
		 */
		// 这里加上限制 防止和jquery判断重合
		if ("".equals(name) || name == null || name == "") {
			modelMap.addAttribute("success", "error");
		} else {
			// 这里注意：最小2，代表必须大于1位
			if (name.length() > 1 && name.length() < 17) {
				// System.out.println("name----------"+name);
				// 唯一校验
				User model = new User();
				model.setName(name);
				List<User> list = userService.getUserInfo(model);
				// 查找，大于0说明有用户；小于0说明没用户
				// 这里的查找 使用 精确 查找sql语句
				// 这里查到了所有，其实是if在起作用，然后是模糊查询
				if (list.size() > 0) {
					// 如果有，返回false,显示“用户已存在”，返回页面；
					// System.out.println("-------------------");
					modelMap.addAttribute("success", Boolean.FALSE);
				} else {
					// 否则，接着执行，此处不显示“用户名可以”，直接执行接下来的数据
					// System.out.println("+++++++++++++++++++++++");
					modelMap.addAttribute("success", Boolean.TRUE);
				}
			} else {
				// 返回结果：false true error --不混乱
				// name不符合标准 返回error限制 不显示/显示空
				modelMap.addAttribute("success", "error");
			}
		}
		return modelMap;
	}

	// 用户注册
	@RequestMapping("/register")
	public ModelAndView register(HttpServletRequest request, HttpSession session) {
		ModelAndView modelView = new ModelAndView("front/login");
		ModelAndView modelAndView2 = new ModelAndView("front/register");
		// ModelMap modelMap=new ModelMap();
		User model = new User();
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String mobile = request.getParameter("mobile");

		// 正确name="nameCheck";错误name=""
		//在js校验里有隐藏的，
		String nameCheck = request.getParameter("nameCheck");
		// System.out.println("--------------------" + nameCheck);
		// System.out.println("---------****-------" + name);
		// 获得验证码，然后转换成大写
		String code = request.getParameter("code");
		String upperCode = "";
		// 防止出现空指针异常
		if (code != null) {
			upperCode = code.toUpperCase();
		}
		// System.out.println("*****************"+upperCode);
		// System.out.println("*************"+code);
		// 这里要如果直接输入地址跳转注册，没有判断，会直接添加空的，然后跳转
		// 这里做空的判断，不显示错误信息，应为直接输入地址，就是啥都没写，
		// 这个和登陆一样，出现这个问题原因在意mapper.xml写的大众化
		if (name != null && password != null && email != null && mobile != null) {
			// 验证唯一性 --设置成true 更直观，类似于记住密码
			if (nameCheck.equals("nameCheck")) {
				// 获得验证码
				String codes = (String) session.getAttribute("code");
				// 问题：做一个 验证码 空的时候判断 ，主要针对 刚输入网址，没填验证码..这里貌似不用管
				// 简答：其实这里为空，在上一步输入链接就做了判断，直接跳转没有任何显示
				// 这里的验证码，只能是大写的

				if (codes.equals(upperCode)) {
					model.setName(name);
					// 加密
					password = Md5.md5(password);
					model.setPassword(password);
					// System.out.println("-----------"+password);
					model.setEmail(email);
					model.setMobile(mobile);
					SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
					model.setRegisterDate(df.format(new Date()));
					model.setPicture("zc.jpg");
					// 加入数据库
					userService.save(model);
					return modelView;
				} else {
					// 提示验证码错误
					String codeError = "验证码有误！";
					request.setAttribute("codeError", codeError);
					return modelAndView2;
				}
			} else {
				// 防止唯一验证，不正确，直接跳转，不加 “为空” 提示
				return modelAndView2;
			}
		} else {
			// 输入网址，直接跳转注册页面，不执行注册功能，不加 “为空” 提示
			return modelAndView2;
		}
	}

	// 用户登录
	@RequestMapping("/login")
	public String login(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws UnsupportedEncodingException {
		// ModelAndView modelAndView1 = new ModelAndView("front/success");
		// ModelAndView modelAndView2 = new ModelAndView("front/login");

		User model = new User();
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String remember = request.getParameter("remember");

		// 不空判断
		if (name != null && password != null) {
			// 记住密码
			if ("true".equals(remember)) {
				// 中文乱码-创建cookie
				String nameUrl = URLEncoder.encode(name, "utf-8");
				Cookie cookieName = new Cookie("COOKIENAME", nameUrl);
				// 设置时间
				cookieName.setMaxAge(7 * 24 * 3600);
				// 添加
				response.addCookie(cookieName);
				String passwordUrl = URLEncoder.encode(password, "utf-8");
				Cookie cookiePassword = new Cookie("COOKIPASSWORD", passwordUrl);
				cookiePassword.setMaxAge(7 * 24 * 3600);
				response.addCookie(cookiePassword);
			} else {
				// 中文乱码-创建cookie
				String nameUrl = URLEncoder.encode(name, "utf-8");
				Cookie cookieName = new Cookie("COOKIENAME", nameUrl);
				// 销毁cookie，就是把时间设置成0；
				cookieName.setMaxAge(0);
				response.addCookie(cookieName);
				String passwordUrl = URLEncoder.encode(password, "utf-8");
				Cookie cookiePassword = new Cookie("COOKIPASSWORD", passwordUrl);
				cookiePassword.setMaxAge(0);
				response.addCookie(cookiePassword);
			}

			// 得到的密码要加密，然后存入model，在进行查询
			password = Md5.md5(password);
			// 找到匹配的判断
			model.setName(name);
			model.setPassword(password);
			// 查询，换成name,password精确查找
			List<User> list = userService.getUserOne(model);
			/*
			 * 两个判断的标准不一样，只能用size;查询是模糊查询，所以name也能会有值 int s = list.size(); User
			 * g = list.get(0); for(int i=0;i<list.size();i++){
			 * System.out.println("list集合的值如下："+list.get(i)); }
			 * System.out.println(g); System.out.println(s);
			 */
			if (list.size() > 0) {
				/*
				 * 查询完成后，修改时间 1.得到id 2.设置登录时间 3.修改数据
				 */
				Integer id = list.get(0).getId();
				// String i = Integer.toString(id);
				// i=request.getParameter(i);
				model.setId(id);
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
				model.setLoginDate(df.format(new Date()));
				userService.update(model);

				// 找到跳转
				// 1.首页的查询
				Information Information = new Information();
				List<Information> listInformation = informationService.getInformations(Information);
				request.setAttribute("list", listInformation);
				/*
				 * for(int i=0;i<listInformation.size();i++){
				 * System.out.println("------");
				 * System.out.println(listInformation.get(i)); }
				 */

				// 2.存入session
				// 注意：不能直接session.setAttribute("user", list);这样manager的值，不能指到实体类
				session.setAttribute("user", list.get(0));
				return "forward:/index.jsp";
			} else {
				// 没有找到不跳,错误提示
				String error = "用户名或密码错误";
				request.setAttribute("error", error);
				return "front/login";
			}
		} else {
			// 没有输入，不跳
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
		/*
		 * (1),用户个人信息 1.获得 隐藏的id，找到属于自己的信息（这个id是session中的，使用request获取） 2.强中转换
		 * 3.根据id，查找信息 4.提交数据
		 */
		User userOne = new User();
		String id = request.getParameter("id");
		// if(id!="" || id!=null) 写法错误？？？
		// 这种判断的话，如果在URL中加入id=？，那么就能跳转了，这样最有危险，所以要拦截
		// 不加这个判断，在拦截器没做之前，会有 ‘空指针异常’
		if (!"".equals(id)) {
			//用户个人信息
			userOne.setId(Integer.parseInt(id));
			List<User> listOne = userService.getUsers(userOne);
			
			/*
			 * （2），所有用户的信息 1.再new一个， 2.查找，重新写一个select(其实也可以换成‘普通时间’，不需要再写select)
			 * 但是要限查询的人数，必须使用sql分页语句，所以重写select 3.提交数据
			 */
			User model = new User();
			List<User> listUser = userService.getUserLoginDate(model);
			/*
			 * (3)言论的所有信息 1.个人的言论，需要id 2.查找 注意：这里虽然有id，查找个人的，但是查询出来的是list
			 */
			Argument argument = new Argument();
			argument.setUserId(Integer.parseInt(id));
			// 获得page，如果page=0，工具类里有判断处理
			String page = request.getParameter("page");
			int size = 6;
			int offset = PageUtil.offset(page, size);
			argument.setOffset(offset);
			argument.setSize(size);
			// 分页显示
			List<Argument> listArgumentOnes = argumentService.getArgumentPageOne(argument);
			//个人相册
			Album album=new Album();
			album.setUserId(Integer.parseInt(id));
			List<Album> listOneAlbum = albumService.getAlbums(album);
//			System.out.println("**********"+listOneAlbum.size());
			
			if (listOne.size() > 0) {
				// a.个人信息
				request.setAttribute("userOne", listOne.get(0));
				// b.所有用户信息
				request.setAttribute("userList", listUser);
				// c.个人的言论信息
				request.setAttribute("listArgumentOnes", listArgumentOnes);
				// d.个人相册信息
				request.setAttribute("listOneAlbum", listOneAlbum);
				
				// 总记录数
				int count = argumentService.getCountOne(Integer.parseInt(id));
				request.setAttribute("count", count);
				// 当前页
				request.setAttribute("currentPage", PageUtil.currentPage(page));
				// 总页数
				request.setAttribute("totalPage", PageUtil.totalPage(count, size));

				// 成功跳转
				return modelAndView1;
			} else {
				// 没有查到用户
				// 跳转到 登录页面 ,不靠谱
				return modelAndView2;
			}
		} else {
			// 前台没有传过id
			// 跳转到 登录页面 不靠谱
			return modelAndView2;
		}
	}

	/*
	 * @PathVariable 可以映射URL中的 参数
	 */
	// 用户修改--查询到用户
	@RequestMapping(value = "/userUpdate/{id}")
	public ModelAndView userUpdate(HttpServletRequest request, @PathVariable("id") Integer id) {
		ModelAndView modelAndView1 = new ModelAndView("front/userUpdate");
		ModelAndView modelAndView2 = new ModelAndView("front/login");
		User model = new User();
		model.setId(id);
		List<User> listOne = userService.getUsers(model);
		if (listOne.size() > 0) {
			request.setAttribute("listOne", listOne.get(0));
			return modelAndView1;
		} else {
			return modelAndView2;
		}
	}

	// 用户修改
	@RequestMapping("/userEdit")
	public String userEdit(HttpServletRequest request) {
//		ModelAndView modelAndView1 = new ModelAndView("front/success1");
		// ModelAndView modelAndView2=new ModelAndView("front/userUpdate");
		// 1.得到服务器地址
		String path = this.servletContext.getRealPath("/tmp/");
		// 2.获得文件 名字
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
		// 没有修改图片，修改了其他的，先来个修改操作
		// 不能加null判断，因为或得到的file不为空
		// 因为执行的是修改操作，不担心回添加两次；；如果是添加，第二个用修改
		boolean b = userService.update(model);

		try {
			// 2-1 对文件处理
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
			// 图片修改后，来个修改操作
			userService.update(model);
			// if(b==true){
			// String a="------------chenggong";
			// System.out.println(a);
			// }else{
			// String a="--------------shibai";
			// System.out.println(a);
			// }
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "redirect:/index.jsp";
	}

	// 修改密码-页面跳转
	@RequestMapping("/userEditPassView")
	public ModelAndView userEditPassView(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView("front/userEditPassView");
		String id = request.getParameter("id");
		User model = new User();
		model.setId(Integer.parseInt(id));
		List<User> list = userService.getUsers(model);
		modelAndView.addObject("user", list.get(0));
		return modelAndView;
	}

	// 修改密码-参数操作
	@RequestMapping("/userEditPass")
	public String userEditPass(HttpServletRequest request) {
//		ModelAndView modelAndView = new ModelAndView("/front/success2");
//		ModelAndView modelAndView1 = new ModelAndView("/front/userEditPassView");
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		User model = new User();
		// 得到的密码要加密，然后存入model
		password = Md5.md5(password);
		model.setId(Integer.parseInt(id));
		model.setPassword(password);
		boolean bool = userService.update(model);
		if (bool == true) {
			return "redirect:/index.jsp";
		} else {
			return "front/login";
		}
	}
	
	//查看用户
	@RequestMapping("/lookUser")
	public ModelAndView lookUser(HttpServletRequest request){
		ModelAndView modelAndView=new ModelAndView("front/lookUser");
		ModelAndView modelAndView1=new ModelAndView("front/login");
		String id=request.getParameter("id");
		User model=new User();
		model.setId(Integer.parseInt(id));
		//查询判断
		List<User> one = userService.getUsers(model);
		if(one.size()>0){
			List<User> userOne = userService.getUsers(model);
			/*
			 * 言论的所有信息 1.个人的言论，需要id 2.查找 注意：这里虽然有id，查找个人的，但是查询出来的是list
			 */
			Argument argument = new Argument();
			argument.setUserId(Integer.parseInt(id));
			// 获得page，如果page=0，工具类里有判断处理
			String page = request.getParameter("page");
			int size = 6;
			int offset = PageUtil.offset(page, size);
			argument.setOffset(offset);
			argument.setSize(size);
			// 分页显示
			List<Argument> listArgumentOnes = argumentService.getArgumentPageOne(argument);
			//个人相册
			Album album=new Album();
			album.setUserId(Integer.parseInt(id));
			List<Album> listOneAlbum = albumService.getAlbums(album);
			
			// a.个人信息
			request.setAttribute("userOne", userOne.get(0));
			// c.个人的言论信息
			request.setAttribute("listArgumentOnes", listArgumentOnes);
			// d.个人相册信息
			request.setAttribute("listOneAlbum", listOneAlbum);
			
			// 总记录数
			int count = argumentService.getCountOne(Integer.parseInt(id));
			request.setAttribute("count", count);
			// 当前页
			request.setAttribute("currentPage", PageUtil.currentPage(page));
			// 总页数
			request.setAttribute("totalPage", PageUtil.totalPage(count, size));
			
			return modelAndView;
		}else{
			return modelAndView1;
		}
	}

}
