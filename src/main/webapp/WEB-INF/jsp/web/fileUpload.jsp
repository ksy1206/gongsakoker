<%-- <%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> --%>
<%-- <jsp:forward page="member/intro.do"/> --%>
<%@ page language="java" contentType="text/html;charset=utf-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.io.File"%>
<%@ page
   import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP Page</title>
</head>
<body>

   <%String cp = request.getContextPath();
      boolean isMultipart = ServletFileUpload.isMultipartContent(request);
      if (!isMultipart) {
         out.println("not! ");
      } else {
         out.println("multipart!");
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
               out.println("FormField");
               String name = item.getFieldName();
               String value = item.getString();
               System.out.println("Parameters " + name + " value " + value);

            } else {
               out.println("else FormField");
               try {
                  String itemName = item.getName();                  
                  
                  File root = File.listRoots()[0];
                  
                  File f = new File("c:/"  + itemName);
                  f.setWritable(true);
                  f.setReadable(true);
                  item.write(f);

               } catch (Exception e) {
                  e.printStackTrace();
               }
            }
         }
      }
   %>

</html>