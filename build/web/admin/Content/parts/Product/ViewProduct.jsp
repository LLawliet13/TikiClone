<%-- 
    Document   : Product
    Created on : Oct 4, 2021, 1:28:14 PM
    Author     : DELL
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="model.DAOProduct"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% // DAOProduct dao = new DAOProduct();
            ResultSet rs = (ResultSet) request.getAttribute("rs");
            String uri = request.getRequestURI();
            String pageName = uri.substring(uri.lastIndexOf("/")+1);
        %>



       


            <table class="table w-auto">


                <thead class="thead-light">
                <th scope="col" >pid</th>
                <th scope="col" >pname</th>

                <th scope="col" >quantity</th>
                <th scope="col" >price</th>
                <th scope="col" >image</th>
                <th scope="col" >description</th>
                <th scope="col" >cateId</th>
                <th scope="col" >status</th>
                <th scope="col" >update</th>
                <th scope="col" >delete</th>
                </thead>
                <tbody>
                    <%if (rs != null) {%>
                    <%while (rs.next()) {%>
                    <tr>

                        <td><%=rs.getString("pid")%></td>
                        <td><%=rs.getString("pname")%></td>
                        <td><%=rs.getInt("quantity")%></td>
                        <td><%=rs.getDouble("price")%></td>
                        <td><img src="<%=rs.getString("Image")%>" width="100px" height="100px"/>
                        </td>
                        <td><%=rs.getString("description")%></td>
                        <td><%=rs.getInt("cateid")%></td>
                        <td><%=(rs.getInt("status") == 1 ? "enable" : "disable")%></td>

                        <td><a href="ControllerProduct?action=update&&pid=<%=rs.getString("pid")%>&&url=<%=pageName%>&&managertype=productmanager&&option=openform&&formtype=update">update</a></td>
                        <td><a href="ControllerProduct?action=delete&&pid=<%=rs.getString("pid")%>&&url=<%=pageName%>">delete</a></td>

                    </tr>
                    <%}%>
                </tbody>
            </table>
            <%}%>

    </body>
</html>
