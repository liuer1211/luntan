package com.forum.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.forum.pojo.Album;
import com.forum.pojo.Photo;
import com.forum.pojo.User;
import com.forum.service.AlbumService;
import com.forum.service.PhotoService;
import com.forum.service.UserService;

@Controller
@RequestMapping("/photo")
public class PhotoController implements ServletContextAware {
	@Autowired
	public PhotoService photoService;
	@Autowired
	public UserService userService;
	@Autowired
	public AlbumService albumService;

	// 为上传文件做准备，找地址
	private ServletContext servletContext;

	@Override
	public void setServletContext(ServletContext context) {
		this.servletContext = context;
	}

	@RequestMapping("/photoStart")
	public ModelAndView getPhotoView(HttpServletRequest request) {
		ModelAndView modelAndView1 = new ModelAndView("front/photo");
		String albumId = request.getParameter("albumId");
		Photo model = new Photo();
		model.setAlbumId(Integer.parseInt(albumId));
		List<Photo> list = photoService.getPhotos(model);
		// 有没有图片都得跳转，页面做判断
		if (list.size() > 0) {
			request.setAttribute("list", list);
			//传递albumId，作隐藏，这里直接把获得到的albumId传过去
			request.setAttribute("listAlbumId", albumId);
			return modelAndView1;
		} else {
			//传递albumId，作隐藏，这里直接把获得到的albumId传过去
			request.setAttribute("listAlbumId", albumId);
			return modelAndView1;
		}
	}
	@RequestMapping("/photoListStart")
	public ModelAndView photoListStart(HttpServletRequest request) {
		ModelAndView modelAndView1 = new ModelAndView("front/photos");
		String albumId = request.getParameter("albumId");
		Photo model = new Photo();
		model.setAlbumId(Integer.parseInt(albumId));
		List<Photo> list = photoService.getPhotos(model);
		// 有没有图片都得跳转，页面做判断
		if (list.size() > 0) {
			request.setAttribute("list", list);
			//传递albumId，作隐藏，这里直接把获得到的albumId传过去
			request.setAttribute("listAlbumId", albumId);
			return modelAndView1;
		} else {
			//传递albumId，作隐藏，这里直接把获得到的albumId传过去
			request.setAttribute("listAlbumId", albumId);
			return modelAndView1;
		}
	}

	// 添加相册，跳转
	@RequestMapping("/photoAddView")
	public ModelAndView albumAddView(HttpServletRequest request) {
		ModelAndView modelAndView1 = new ModelAndView("/front/photoAdd");
		ModelAndView modelAndView2 = new ModelAndView("/front/login");
		String albumId = request.getParameter("albumId");
		Album model = new Album();
		model.setId(Integer.parseInt(albumId));
		// 查询相册，找到id，传到页面，隐藏起来
		List<Album> listOneAlbum = albumService.getAlbums(model);
		request.setAttribute("listOneAlbum", listOneAlbum.get(0));
		return modelAndView1;
	}

	// 添加图片
	@RequestMapping("/photoSave")
	public String photoSave(HttpServletRequest request) {
//		ModelAndView modelAndView1 = new ModelAndView("front/success");
		String albumId = request.getParameter("albumId");
		// 1.得到服务器地址
		String path = this.servletContext.getRealPath("/tmp/");
		// System.out.println("path----"+path);
		// 获取文件 名字，页面上的
		MultipartHttpServletRequest mrep = (MultipartHttpServletRequest) request;
		MultipartFile file = mrep.getFile("picture");
//		file=org.springframework.web.multipart.commons.CommonsMultipartFile@2b57f23
		System.out.println("file="+file);
		Photo model = new Photo();
		model.setAlbumId(Integer.parseInt(albumId));
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		model.setCreateDate(sdf1.format(new Date()));
		// 选择图片后
		try {
			// 2-1.对文件进行处理
			String fileName = file.getOriginalFilename();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			// 3.先定义
			String newfile = sdf.format(new Date()) + fileName.substring(fileName.lastIndexOf('.'));
			// 4.在使用
			FileOutputStream fos = new FileOutputStream(path + newfile);
			// 5.关闭流
			fos.write(file.getBytes());
			fos.flush();
			fos.close();
			// 6.设置文件，添加数据库
			model.setPicture(newfile);
			//
			photoService.photoSave(model);
		} catch (Exception e) {
		}
		return "redirect:/index.jsp";
	}
	
	//下载图片
	@RequestMapping("/photoDown")
	public ResponseEntity<byte[]> photoDown(HttpServletRequest request,@RequestParam("filename") String filename,
            Model model) throws IOException {
		String path = this.servletContext.getRealPath("/tmp/");
		String downloadFilePath=path;//从我们的上传文件夹中去取
        System.out.println(path);
        File file = new File(downloadFilePath+File.separator+filename);//新建一个文件
        
        HttpHeaders headers = new HttpHeaders();//http头信息
        
        String downloadFileName = new String(filename.getBytes("UTF-8"),"iso-8859-1");//设置编码
        
        headers.setContentDispositionFormData("attachment", downloadFileName);
        
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        
        //MediaType:互联网媒介类型  contentType：具体请求中的媒体类型信息
        
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers,HttpStatus.CREATED);
	}

}
