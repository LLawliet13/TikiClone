<%-- 
    Document   : Call
    Created on : Oct 24, 2021, 1:21:15 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% Object call = request.getAttribute("call");
        if(call==null){
            response.sendRedirect("../ControllerProject");
        }
        out.println(call);
        %>
        
    </body>
</html>
