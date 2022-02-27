<%-- 
    Document   : Panner
    Created on : Oct 19, 2021, 2:43:09 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/pannerstyle.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
              rel="stylesheet">

      
    </head>

    <body>
        <% String uri = request.getRequestURI();

            String pageName = uri.substring(uri.lastIndexOf("/") + 1);
            String user = (String) session.getAttribute("user");
            if(pageName.equals("Panner.jsp")){
            
           
        %>
        <h6> nút showcart k ấn được từ đây vì href đang để cho chạy đc khi chạy trong jsp tag</h6>
        <%}%>
        

        <nav class="navbar navbar-expand-md ">
            <a class="navbar-brand linkItem" href="#" >Project</a>

            <div class="collapse navbar-collapse" >
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                    </li>
                    <%if (user != null) {%>
                    <li class="nav-item ">
                        <a class="nav-link" href="#">Welcome <%=user%> <span class="sr-only">(current)</span></a>
                    </li>
                    <%}%>

                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Tài Khoản
                        </a>
                        <div class="dropdown-menu " aria-labelledby="navbarDropdown">
                            <a class="nav-link linkItem" href="Login.jsp?url=project/<%=pageName%>">Login</a>
                            <a class="nav-link linkItem" href="ControllerProject?action=logout&&url=project/<%=pageName%>">Logout</a>
                            <div class="dropdown-divider linkItem"></div>
                            <a class="nav-link linkItem" href="InsertCustomer.jsp">Register</a>
                        </div>
                    </li>
                    <li class="nav-item">

                        <a class="nav-link" href="project/ShowCartProject.jsp"> <span class="material-icons md-18">shopping_cart </span>ShowCart</a>

                    </li>
                </ul>
            </div>
        </nav>


    </tbody>
</table>
</body>
</html>
