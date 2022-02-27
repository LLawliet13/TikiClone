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
        <style>
            .container{
                margin-top: 10%;
                margin: 10%;
            }
            .right{
                /*margin-left: 5%;*/
            }
            footer{
                margin-top:5%;
            }
        </style>
    </head>
    <script>
//        $(document).ready(function () {
//
//        });


    </script>

    <body>

        <%

            Boolean isDispatched = (Boolean) request.getAttribute("isDispatched");
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

            ResultSet rs = (ResultSet) request.getAttribute("rsPro");
            ResultSet rscate = (ResultSet) request.getAttribute("rscate");
            String register = (String) request.getAttribute("register");
            String showbill = (String) request.getAttribute("showbill");
        %>

        <%
            if (rs == null || rscate == null)
                response.sendRedirect((isDispatched == true ? "" : backPrefixLink) + "ControllerProject");
            else {%>

        <jsp:include page="nav/index.jsp"></jsp:include>

        
        <jsp:include page="content/indexContentMain.jsp"></jsp:include>


        <jsp:include page="footer/index.jsp"></jsp:include>


        <%}%>



    </body>

</html>
