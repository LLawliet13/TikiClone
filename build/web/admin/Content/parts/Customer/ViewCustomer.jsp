<%-- 
    Document   : ViewCustomer
    Created on : Oct 11, 2021, 9:14:01 PM
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
        <% ResultSet rs = (ResultSet) request.getAttribute("rs");
            String uri = request.getRequestURI();
            String pageName = uri.substring(uri.lastIndexOf("/") + 1);

        %>
        <table class="table w-auto">


            <thead class="thead-light">

            <th scope="col" >cid</th>
            <th scope="col" >cname</th>
            <th scope="col" >cphone</th>
            <th scope="col" >CAddress</th>
            <th scope="col" >username</th>
            <th scope="col" >status</th>
            <th scope="col" >Update</th>
            <th scope="col" >delete</th>
        </thead>
        <tbody>
            <%if (rs != null) {%>

            <%while (rs.next()) {%>
            <tr>

                <td><%=rs.getInt("cid")%></td>
                <td><%=rs.getString("cname")%></td>
                <td><%=rs.getString("cphone")%></td>
                <td><%=rs.getString("CAddress")%></td>
                <td><%=rs.getString("username")%></td>
                <td><%=rs.getInt("status") == 1 ? "enable" : "disable"%></td>
                <td><a href="ControllerCustomer?action=update&&cid=<%=rs.getInt("cid")%>&&url=<%=pageName%>&&managertype=customermanager&&option=openform&&formtype=update">update</a></td>
                <td><a href="ControllerCustomer?action=delete&&cid=<%=rs.getInt("cid")%>&&url=<%=pageName%>">delete</a></td>

            </tr>
            <%}%>
        </tbody>
    </table>
    <%}%>

</body>
</html>
