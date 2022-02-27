<%-- 
    Document   : IndexProduct
    Created on : Oct 19, 2021, 12:18:47 PM
    Author     : DELL
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!--<link href="css/indexProject.css" rel="stylesheet" type="text/css">-->
        
        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <style>.container{
                margin-top: 10%;
            }</style>
    </head>
    <script>
        $(document).ready(function () {

        });


    </script>

    <body>
        <div class="pages"></div>
        <%
            ResultSet rs = (ResultSet) request.getAttribute("rsPro");
            ResultSet rscate = (ResultSet) request.getAttribute("rscate");
            if (rs == null||rscate==null)
                response.sendRedirect("../ControllerProject");
            else {

        %>
        <jsp:include page="Panner.jsp"></jsp:include>
            <div class="container">
                <div class="row">
                    <div class="col-sm-3">
                    <jsp:include page="MenuProject.jsp"></jsp:include>
                    </div>
                    <div class="col-sm-9 ">
                    <jsp:include page="Content.jsp"></jsp:include>
                    </div>
                </div>
            </div>
        <%}%>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
