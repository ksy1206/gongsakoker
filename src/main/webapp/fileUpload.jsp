<%@ page language="java" contentType="text/html;charset=utf-8"
   pageEncoding="UTF-8"%>

<%@ page import="java.io.File"%>
<%@page import="java.util.*" %>
<%@page import="java.io.PrintWriter" %>
<%@page import="net.sf.json.JSONObject" %>

<%@ page
   import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
  <%
  JSONObject jsonObject = null;
  String cp = request.getContextPath();
//   out.println("+++++++++++++++++++++++++++++++++++++++++");
  Map<String, Object> rMap = new HashMap<String, Object>();
  PrintWriter outt = null;
  int result = 0;

	 
	session = request.getSession();
 	String doc_root = session.getServletContext().getRealPath("/upload");
  	String os = System.getProperty("os.name");
  	String fileDestPath = "";
//   	out.println("* 현재운영체제 : " + os);

	fileDestPath = doc_root + File.separator + "img"
			+ File.separator + "temp";

// 	out.println("* 파일 저장 경로 : " + fileDestPath);

	File destinationDir = new File(fileDestPath);
	if (!destinationDir.exists()) {
		destinationDir.mkdirs();
	}

  
  boolean isMultipart = ServletFileUpload.isMultipartContent(request);
  if (!isMultipart) {
// 	  out.println("not");
  } else {
	  
// 	  out.println("multipart");
     
     FileItemFactory factory = new DiskFileItemFactory();
     ServletFileUpload upload = new ServletFileUpload(factory);
     
     List items = null;
     
     try {
    	
    	 items = upload.parseRequest(request);
    	 
     
     } catch (FileUploadException e) {
     
    	 e.printStackTrace();
     
     }
    
     Iterator itr = items.iterator();
     
     while (itr.hasNext()) {
        
    	 FileItem item = (FileItem) itr.next();
    
        if (item.isFormField()) {
          
//            out.println("FormField");
           String name = item.getFieldName();
           String value = item.getString();
//            out.println("Parameters " + name + " value " + value);
			
        } else {
           
//         	out.println("else FormField");
        	
           try {

        	  String itemName = item.getName();   
        	  
   
        	  
//              File root = File.listRoots()[0];
              int fileNameIndex = itemName.lastIndexOf("/");
              
         
              
              String fileName = itemName.substring(fileNameIndex,itemName.length());
              
             
              
              String fileType = fileName.substring(fileName.indexOf("."));
              
              File f = new File(fileDestPath + File.separator + fileName);
//               File f = File.createTempFile(fileGbn.toUpperCase(),fileType, destinationDir);
              f.setWritable(true);
              f.setReadable(true);
              item.write(f);

  				long fileSize = item.getSize();
  		
  				rMap.put("fileName", fileName);
  				rMap.put("fileUploadPath", fileDestPath);
  				rMap.put("destination", f.toString());
  				
  				result = 1;
  				
  				rMap.put("resultCode", result);
  				
  				jsonObject = JSONObject.fromObject(rMap);
//   				out.print("json - " + jsonObject);

  				// 아래 부분은 IE8과 IE9에서 업로드후, json데이터를 제대로 받지 못하여 수정함.
//   				response.setContentType("text/plain; charset=UTF-8"); // HttpServletResponse
  																// response

//   			outt = response.getWriter();
  			//outt.print(jsonObject.toString());
//   			outt.flush();

           } catch (Exception e) {
              e.printStackTrace();
           }
        }
     }
  }
   %>

 <%=jsonObject%>
