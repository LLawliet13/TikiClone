<%-- 
    Document   : ViewBillProject
    Created on : Oct 21, 2021, 12:40:32 AM
    Author     : DELL
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bill detail admin</title>
    </head>
    <body>
        <%  String uri = request.getRequestURI();
            String pathName = uri.substring(uri.lastIndexOf("/") + 1);
            ResultSet rs = (ResultSet) request.getAttribute("rs");

        %>
        <table class="table w-auto">


            <thead class="thead-light">
            <th scope="col" >oID</th>
            <th scope="col">dateCreate</th>
            <th scope="col">cname</th>
            <th scope="col">cphone</th>
            <th scope="col">cAddress</th>
            <th scope="col">total</th>
            <th scope="col">status</th>
            <th scope="col">cid</th>
            <%if (pathName.equals("AdminSettings.jsp")) {%>   
            <th scope="col">detail</th>
            <%}%>

        </thead> <tbody>

            <%if (rs != null) {%>
            <%while (rs.next()) {%>
            <tr>
                <td><%=rs.getString("oid")%>
                </td>
                <td><%=rs.getString("dateCreate")%></td>
                <td><%=rs.getString("cname")%></td>
                <td><%=rs.getString("cphone")%></td>
                <td><%=rs.getString("cAddress")%></td>
                <td><%=rs.getDouble("total")%></td>
                <td><%if (rs.getInt("status") == 0) {
                        out.println("wait");
                    } else if (rs.getInt("status") == 1) {
                        out.println("process");
                    } else {
                        out.println("done");
                    }
                    %></td>
                <td><%=rs.getInt("cid")%></td>
                <%if (pathName.equals("AdminSettings.jsp")) {%>    
                <td>
                    
                    <%if (rs.getInt("status") != 2 && rs.getInt("status") != -1) {%>
                    <a href="ControllerProject?action=showbilldetail&&oid=<%=rs.getString("oid")%>&&url=<%=pathName%>">details</a>
                    <%}%>
                    
                </td>
                <%}%>

            </tr>
            <%}
                }%>
        </tbody>
    </table>
    <% if (pathName.equals("ViewBillProject.jsp")) {%>
    <a href="index.jsp">Menu</a>
    <%}%>

</body>
</html>
