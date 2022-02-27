<%-- 
    Document   : ViewBillDetail
    Created on : Oct 7, 2021, 10:09:05 AM
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
        <%ResultSet rs =(ResultSet) request.getAttribute("rs");%>
        <table border="1">

            <tbody>
                <tr>
                    <td>oid</td>
                    <td>pid</td>
                    <td>quantity </td>
                    <td>price </td>
                    <td>total</td>
                    <td>update </td>
                    <td>delete</td>
                </tr>
                <%while(rs.next()){%>
                <tr>
                    <td><%=rs.getString("oid")%></td>
                    <td><%=rs.getString("pid")%></td>
                    <td><%=rs.getInt("quantity")%></td>
                    <td><%=rs.getDouble("price")%></td>
                    <td><%=rs.getDouble("total")%></td>
                    <td><a href=<%="ControllerBillDetail?action=update&&oid="+rs.getString("oid")+"&&pid="+rs.getString("pid")%>>update</a> </td>
                    <td><a href=<%="ControllerBillDetail?action=delete&&oid="+rs.getString("oid")+"&&pid="+rs.getString("pid")%>>delete</a> </td>
                </tr>
                <%}%>
            </tbody>
        </table>

    </body>
</html>
