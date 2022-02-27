<%-- 
    Document   : ViewAdmin
    Created on : Oct 6, 2021, 10:44:17 PM
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
        <%ResultSet rs = (ResultSet)request.getAttribute("rs");%>
        <a href="ControllerAdmin?action=insert">insert admin</a>
        <table border="1">
           
            <tbody>
                <tr>
                    <td>adminID</td>
                    <td>UserName</td>
                    <td>update</td>
                    <td>delete</td>
                </tr>
                <%while(rs.next()){%>
                <tr>
                    <td><%=rs.getString("adminid")%></td>
                    <td><%=rs.getString("username")%></td>
                    <td><a href=<%="ControllerAdmin?action=update&&adminid="+rs.getString("adminid")%>>update</a></td>
                    <td><a href=<%="ControllerAdmin?action=delete&&adminid="+rs.getString("adminid")%>>delete</a></td></td>
                </tr>
                <%}%>
            </tbody>
        </table>

    </body>
</html>
