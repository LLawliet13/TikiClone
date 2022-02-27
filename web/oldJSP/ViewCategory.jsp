<%-- 
    Document   : ViewCategory
    Created on : Oct 6, 2021, 10:26:53 PM
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
        <% ResultSet rs = (ResultSet)request.getAttribute("rs");%>
        <a href="ControllerCategory?action=insert">insert category</a>
        <%if(rs!=null){%>
        <table border="1">
       
            <tbody>
                <tr>
                    <td>CateID</td>
                    <td>Cate name</td>
                    <td>status</td>
                    <td>Update</td>
                    <td>delete</td>
                </tr>
                <%while(rs.next()){%>
                <tr>
                    
                    <td><%=rs.getInt("cateid")%></td>
                    <td><%=rs.getString("catename")%></td>
                    <td><%=rs.getInt("status")==1?"enable":"disable"%></td>
                    <td><a href=<%="ControllerCategory?action=update&&cateid="+rs.getInt("cateid")%>>update</a></td>
                    <td><a href=<%="ControllerCategory?action=delete&&cateid="+rs.getInt("cateid")%>>delete</a></td>
                    
                </tr>
                <%}%>
            </tbody>
        </table>
            <%}%>

    </body>
</html>
