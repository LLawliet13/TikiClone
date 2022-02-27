<%-- 
    Document   : Panner
    Created on : Oct 19, 2021, 2:43:09 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
        Boolean isDispatched = (Boolean) request.getAttribute("isDispatched");
        if(isDispatched==null){
            isDispatched = false;
        }
        
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        <link href="<%=isDispatched==true? "css/pannerstyle.css":"../css/pannerstyle.css"%>" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
              rel="stylesheet">


    </head>

    <body>
        <% String uri = request.getRequestURI();
            
            String pageName = uri.substring(uri.lastIndexOf("/") + 1);
            String admin = (String) session.getAttribute("admin");
            

        %>
        <!--<h6> nút showcart k ấn được từ đây vì href đang để cho chạy đc khi chạy trong jsp tag</h6>-->
     


        <nav class="navbar navbar-expand-md ">
            <a class="navbar-brand linkItem" href="<%=isDispatched==true? "admin/AdminSettings.jsp":"AdminSettings.jsp"%>">AdminSettings<span class="sr-only">(current)</span></a>

            <div class="collapse navbar-collapse" >
               
                <ul class="navbar-nav mr-auto">
                     <%if (admin != null) {%>

                    <li class="nav-item ">
                        <a class="nav-link" href="#">Welcome <%=admin%> <span class="sr-only">(current)</span></a>
                    </li>
<!--                    <li class="nav-item active">
                        <a class="nav-link" href="AdminSettings.jsp">Admin Settings <span class="sr-only">(current)</span></a>
                    </li>-->
                    <%}%>

                </ul>
                
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Tài Khoản
                        </a>
                        <div class="dropdown-menu " aria-labelledby="navbarDropdown">
                            <% 
                            if(admin==null){%>
                            <a class="nav-link linkItem" href="<%=isDispatched==true? "admin/feature/Admin/Adminlogin.jsp?url=":"feature/Admin/Adminlogin.jsp?url="%><%=pageName%>">Login</a>
                            <%}%>
                            <% 
                            if(admin!=null){%>
                            <a class="nav-link linkItem" href="<%=isDispatched==true? "ControllerAdmin?action=adminlogout&&url=":"../ControllerAdmin?action=adminlogout&&url="%><%=pageName%>">Logout</a>
                            <%}%>
                            <!--<div class="dropdown-divider linkItem"></div>-->
                        </div>
                    </li>
                </ul>
            </div>
        </nav>


    </tbody>
</table>
</body>
</html>
