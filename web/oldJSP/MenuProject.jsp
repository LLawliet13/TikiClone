<%-- 
    Document   : Menu_Project
    Created on : Oct 19, 2021, 3:16:37 AM
    Author     : DELL
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

    </head>
    <body>

        <% String uri = request.getRequestURI();
            String pageName = uri.substring(uri.lastIndexOf("/") + 1);
            ResultSet rsCate = (ResultSet) request.getAttribute("rscate");
            if (rsCate == null) {
               
                response.sendRedirect("../ControllerProject?urljsp=project/"+pageName);
                
            }
        %>




        <%if (rsCate != null) {%>


        <ul class="list-group">
            <li class="list-group-item active ">Category</li>
            <li class="list-group-item list-group-item-action "><a href="ControllerProject?action=selectcategory&&cateid=all&&urljsp=project/<%= pageName%>">All</a></li>

            <% while (rsCate.next()) {%>
            <li class="list-group-item list-group-item-action"  value="<%=rsCate.getInt("cateid")%>"><a href="ControllerProject?action=selectcategory&&cateid=<%=rsCate.getInt("cateid")%>&&urljsp=project/<%= pageName%>">
                    <%=rsCate.getString("catename")%></a></li>

            <%}%>
        </ul>

        <%}%>
    </body>
</html>
