<%-- 
    Document   : item_list
    Created on : Nov 7, 2021, 8:19:21 PM
    Author     : DELL
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">
        <style>
            .card{
                padding:5px;
            }
            .hided{
                visibility: hidden;
            }
            .row_product{
                margin-bottom: 20px;
            }
            .card-body{
                z-index: 0;
            }
        </style>
    </head>
    <body>
        <%
            Boolean isDispatched = (Boolean) request.getAttribute("isDispatched");
            if (isDispatched == null) {
                isDispatched = false;
            }
            String uri = request.getRequestURI();

            String pageName = uri.substring((uri.substring(uri.indexOf("/") + 1)).indexOf("/") + 2);

            String[] parts = uri.split("/");
            int numberofSlash = parts.length - 3;
            String backPrefixLink = "";
            while (numberofSlash > 0) {
                backPrefixLink += "../";
                numberofSlash--;
            }

            ResultSet rs = (ResultSet) request.getAttribute("rsPro");//danh sách sản phẩm in ra
            if (rs == null) {
                response.sendRedirect((isDispatched == true ? "" : backPrefixLink) + "ControllerProject?url=" + pageName);
            } else {
        %>
        <jsp:include page="hot_item_list/navbar/index.jsp"/>
        <jsp:include page="hot_item_list/list_item/index.jsp"/>

        <%}%>
    </body>
</html>
