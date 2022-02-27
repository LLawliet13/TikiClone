<%-- 
    Document   : ViewBill
    Created on : Oct 6, 2021, 10:55:30 PM
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
        <% ResultSet rs =(ResultSet) request.getAttribute("rs");%>
        <table border="1">
        
            <tbody>
                 <%if(rs!=null){%>
                <tr>
                    <td>oID</td>
                    <td>dateCreate</td>
                    <td>cname</td>
                    <td>cphone</td>
                    <td>cAddress</td>
                    <td>total</td>
                    <td>status</td>
                    <td>cid</td>
                    <td>update</td>
                    <td>delete</td>

                </tr>
               
                <%while(rs.next()){%>
                <tr>
                    <td><%=rs.getString("oid")%>
                        <a href=<%="ControllerBillDetail?action=search&&oid="+rs.getString("oid")%>>details</a></td>
                    <td><%=rs.getString("dateCreate")%></td>
                    <td><%=rs.getString("cname")%></td>
                    <td><%=rs.getString("cphone")%></td>
                    <td><%=rs.getString("cAddress")%></td>
                    <td><%=rs.getDouble("total")%></td>
                    <td><%=rs.getInt("status")==1?"enable":"disable"%></td>
                    <td><%=rs.getInt("cid")%></td>
                    
                    <td><a href=<%="ControllerBill?action=update&&oid="+rs.getString("oid")%>>update</a></td>
                    <td><a href=<%="ControllerBill?action=delete&&oid="+rs.getString("oid")%>>delete</a></td>
                    
                </tr>
                <%}}%>
            </tbody>
        </table>
            <a href="Menu.jsp">Menu</a>

    </body>
</html>
