<%-- <%@ page import="com.iscas.qd.fastdfs.service.IStorageClientService" %>
<%@ page import="com.iscas.qd.fastdfs.service.impl.StorageClientService" %>
<%@ page import="java.util.*,java.io.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.json.simple.*" %>
<%@ page import="com.gph.saviorframework.util.FDFSUtils" %>
<%@ page import="com.iscas.qd.fastdfs.StorePath" %>
<%@ page import="com.gph.saviorframework.util.PropertiesUtils" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String realpath = request.getRealPath("/WEB-INF/classes");
    PropertiesUtils pu = new PropertiesUtils();
    Properties properties = pu.loadProperty("keepalived.properties");
    ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
    IStorageClientService storageClientService = ctx.getBean(StorageClientService.class);

    //定义允许上传的文件扩展名
    HashMap<String, String> extMap = new HashMap<String, String>();
    extMap.put("image", "gif,jpg,jpeg,png,bmp");
    extMap.put("flash", "swf,flv");
    extMap.put("media", "swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb,mp4");
    extMap.put("file", "doc,docx,xls,xlsx,ppt,htm,html,txt,zip,rar,gz,bz2");

    //最大文件大小
    long maxSize = 10000000;

    response.setContentType("text/html; charset=UTF-8");

    if(!ServletFileUpload.isMultipartContent(request)){
        out.println(getError("请选择文件。"));
        return;
    }

    FileItemFactory factory = new DiskFileItemFactory();
    ServletFileUpload upload = new ServletFileUpload(factory);
    upload.setHeaderEncoding("UTF-8");
    List items = upload.parseRequest(request);
    Iterator itr = items.iterator();
    while (itr.hasNext()){
        FileItem item = (FileItem) itr.next();
        String fileName = item.getName();
        long fileSize = item.getSize();
        if (!item.isFormField()){
            //检查文件大小
            if(item.getSize() > maxSize){
                out.println(getError("上传文件大小超过限制。"));
                return;
            }
           /* //检查扩展名
            String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
            if(!Arrays.<String>asList(extMap.get(dirName).split(",")).contains(fileExt)){
                out.println(getError("上传文件扩展名是不允许的扩展名。\n只允许" + extMap.get(dirName) + "格式。"));
                return;
            }*/
            StorePath storePath =
                FDFSUtils.uploadFile(null,storageClientService,item.getInputStream(),fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase());
            if(storePath!=null){
                JSONObject obj = new JSONObject();
                obj.put("error", 0);
                obj.put("url", "http://"+properties.getProperty("vip")+"/"+storePath.getGroup()+"/"+storePath.getPath());
                out.println(obj.toJSONString());
            }
        }
    }
%>
<%!
    private String getError(String message) {
        JSONObject obj = new JSONObject();
        obj.put("error", 1);
        obj.put("message", message);
        return obj.toJSONString();
    }
%> --%>