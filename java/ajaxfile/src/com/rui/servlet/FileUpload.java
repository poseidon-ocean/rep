package com.rui.servlet;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * 文件上传的处理类
 * @author hjt
 * @date 2015-10-14
 *
 */
@SuppressWarnings("serial")
//urlPatterns={"/fileUp.do"}  这里的/不能少
@WebServlet(name="fileUp",urlPatterns={"/fileUp.do","/fileUp.action"})
public class FileUpload extends HttpServlet {

	@SuppressWarnings("unchecked")
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		/**
		 * 使用工具apache提供的第三方jar包
		 * 
		 */
		
		//创建一个文件上传的磁盘工厂
		FileItemFactory factory = new DiskFileItemFactory();
		//创建容器的文件上传类
		ServletFileUpload upload = new ServletFileUpload(factory);
		//解析请求域中的文件
		List<FileItem> fileItems; //文件列表 
		
		StringBuffer result = new StringBuffer();
		try {
			fileItems = upload.parseRequest(request);
			if(fileItems != null){
				//指定文件的目录  一般是FTP文件服务器,这里放在项目下 
				String uploadFolder = request.getServletContext().getRealPath("upload");
				for(FileItem fileItem:fileItems){
					try {
						fileItem.write(new File(uploadFolder,fileItem.getName()));
						if(result.length()>0){
							result.append(",");
						}
						result.append("'upload/"+fileItem.getName()+"'");
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				String tmp = "var filePaths = ["+result+"]";
				response.getWriter().print(tmp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
}
