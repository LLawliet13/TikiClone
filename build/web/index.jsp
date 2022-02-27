<%-- 
    Document   : index
    Created on : Nov 27, 2021, 4:11:59 PM
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
            body{
                background-color: #f5f5fa;

            }

        </style>
        <script>
//            window.addEventListener('load', (event) => {
//                console.log('page is fully loaded');
//            });



        </script>
    </head>
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
        <jsp:include page="user/pages/main/indexMain.jsp"/>
        <%}%>




    </body>
</html>
