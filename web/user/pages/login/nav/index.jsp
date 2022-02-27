<%-- 
    Document   : Panner
    Created on : Oct 19, 2021, 2:43:09 AM
    Author     : DELL
--%>

<%@page import="model.DBConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
           <% Boolean isDispatched = (Boolean) request.getAttribute("isDispatched");
            if (isDispatched == null) {
                isDispatched = false;
            }
            String uri = request.getRequestURI();
            String pageName = uri.substring(uri.lastIndexOf("/") + 1);
            String[] parts = uri.split("/");
            int numberofSlash = parts.length - 3;
            String backPrefixLink = "";
            while (numberofSlash > 0) {
                backPrefixLink += "../";
                numberofSlash--;
            }

            String user = (String) session.getAttribute("user");


        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="<%=(isDispatched==true?"":backPrefixLink)%>user/pages/showcart/nav/pannerstyle.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
              rel="stylesheet">


    </head>

    <body>
     




        <nav class="navbar navbar-expand-md ">
            <a class="navbar-brand linkItem" href="<%=(isDispatched == true ? "" : backPrefixLink)%>user/index.jsp" >Project</a>

            <div class="collapse navbar-collapse" >

                <ul class="navbar-nav mr-auto">
                    <%if (user != null) {%>
                    <%  DBConnect dao = new DBConnect();
                        ResultSet rs = dao.getData("select * from customer where username = '" + user + "'");
                        rs.next();
                    %>
                    <li class="nav-item ">
                        <a class="nav-link" href="#">Welcome <%=rs.getString("cname")%> <span class="sr-only">(current)</span></a>
                    </li>
                    <%}%>

                </ul>

                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Tài Khoản
                        </a>
                        <div class="dropdown-menu " aria-labelledby="navbarDropdown">
                            <%if (user == null) {%>
                            <a class="nav-link linkItem" href="<%=(isDispatched==true?"":backPrefixLink)%>user/pages/login/index.jsp?url=<%=pageName%>">Login</a>
                            <div class="dropdown-divider linkItem"></div>
                            <a class="nav-link linkItem" href="<%=(isDispatched == true ? "" : backPrefixLink)%>ControllerCustomer?action=insert&&url=index.jsp&&register=show">Register</a>

                            <%}%>
                            <% if (user != null) {%>
                            <a class="nav-link linkItem" href="<%=(isDispatched == true ? "" : backPrefixLink)%>ControllerProject?action=showbillcustomer&&user=<%=user%>&&url=<%=pageName%>">My Bill</a>
                            <a class="nav-link linkItem" href="<%=(isDispatched == true ? "" : backPrefixLink)%>ControllerProject?action=userlogout&&url=<%=pageName%>">Logout</a>
                            <%}%>

                        </div>
                    </li>
                    <li class="nav-item">

                        <a class="nav-link" href="<%=(isDispatched==true?"":backPrefixLink)%>user/pages/showcart/index.jsp"> <span class="material-icons md-18">shopping_cart </span>ShowCart</a>
                    </li>
                </ul>
            </div>
        </nav>


    </tbody>
</table>
</body>
</html>
