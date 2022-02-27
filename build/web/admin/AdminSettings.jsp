<%-- 
    Document   : AdminSettings
    Created on : Oct 24, 2021, 11:12:19 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <style>.container{
                margin-top: 10%;
            }</style>
    </head>
    <body>
        <% String admin = (String) session.getAttribute("admin");
            String managerType = (String) request.getAttribute("managertype");
            String option = (String) request.getAttribute("option");
            Boolean isDispatched = (Boolean) request.getAttribute("dispatched");
            if(isDispatched==null){
                isDispatched = false;
            }
        %>
        <%if (admin == null) {
                String url = "";
                if (isDispatched == false) {
                    url = "Panner/feature/Admin/Adminlogin.jsp";
                }else{
                    url = "admin/Panner/feature/Admin/Adminlogin.jsp";
                }
                response.sendRedirect(url);
            } else {
                String pannerPage = "";
                String contentPage = "";
                String menuPage = "";
                
                if (isDispatched == true) {
                    pannerPage = "Panner/AdminPanner.jsp";

                    contentPage = "Content/AdminContent.jsp";

                    menuPage = "Menu/AdminMenu.jsp";
                } else {
                    pannerPage = "Panner/AdminPanner.jsp";

                    contentPage = "Content/AdminContent.jsp";

                    menuPage = "Menu/AdminMenu.jsp";
                }

        %>

        <jsp:include page="<%=pannerPage%>"></jsp:include>
            <div class="container">
                <div class="row">

                <%if (option == null || !option.equals("listattribute")) {%>
                <div class="col-sm-3">
                    <jsp:include page="<%=menuPage%>"></jsp:include>
                    </div>
                <%}%>
                <jsp:include page="<%=contentPage%>"></jsp:include>

                </div>
            </div>
        <%}%>

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
