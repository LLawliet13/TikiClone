<%-- 
    Document   : ShowCartProject
    Created on : Oct 20, 2021, 1:59:45 PM
    Author     : DELL
--%>

<%@page import="entity.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            Boolean isDispatched = (Boolean) request.getAttribute("isDispatched");
            if (isDispatched == null) {
                isDispatched = false;
            }
            String uri = request.getRequestURI();
            String pageName = uri.substring((uri.substring(uri.indexOf("/") + 1)).indexOf("/") + 2);
            String[] parts = uri.split("/");
            int numberofSlash = parts.length - 3;
            String backPrefixLink = "";
            while (numberofSlash > 0) {
                backPrefixLink += "../";
                numberofSlash--;
            }


        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/itemliststyle.css" rel="stylesheet" type="text/css">
      
    </head>
    <body>
        <% Integer cid = (Integer) session.getAttribute("user");
            if(cid==null){
                response.sendRedirect((isDispatched == true ? "" : backPrefixLink)+"user/pages/login/index.jsp");
                    
                    }else{
            %>
        <jsp:include page="nav/index.jsp"/>
        <jsp:include page="Content/index.jsp"/>
        <%}%>

    </body>
</html>
