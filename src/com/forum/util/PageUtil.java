package com.forum.util;

public class PageUtil {
	//分页offset--第几页开始--和page,size有关
	public static int offset(String page, int size){
		int offset=0;
		int currentPage=0;//下面page传给它一个值，它其实就是page
		if(page=="" || page==null){
			page="1";
			currentPage=1;
		}else{
			//page不等于空，则强转，赋值给currentPage,即当前页
			currentPage=Integer.parseInt(page);
			offset=(currentPage-1)*size;
		}
		return offset;
	}
	//当前页
	public static int currentPage(String page) {
		//当前页由page绝定
		int currentPage=0;
		if(page == "" || page==null){
			page="1";
			currentPage=1;
		}else{
			currentPage=Integer.parseInt(page);
		}
		return currentPage;
	}
	//总页数--count和size决定
	public static int totalPage(int count,int size) {
		return (count+(size-1))/size;
	}
}
