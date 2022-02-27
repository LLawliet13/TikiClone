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
            String pageName = uri.substring((uri.substring(uri.indexOf("/") + 1)).indexOf("/") + 2);

            String[] parts = uri.split("/");
            int numberofSlash = parts.length - 3;
            String backPrefixLink = "";
            while (numberofSlash > 0) {
                backPrefixLink += "../";
                numberofSlash--;
            }

            Integer user = (Integer) session.getAttribute("user");


        %>
        <link href="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/checkout/nav/style.css" rel="stylesheet" type="text/css">
        <meta charset="UTF-8">
        <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>-->

        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">


        
    </head>

    <body>
        <%
        Integer cid = (Integer) session.getAttribute("user");
        %>

        <div class="header">
            <div class="left_nav">
                <div class="left">
                    <a href="<%=(isDispatched == true ? "" : backPrefixLink)%>index.jsp" >
                        <img class="logo" src="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/main/nav/image/pngegg.png" alt="logo"></a>
                    <div class="bottom">Your Choices</div></div>
                <div class="page_name">

                    Thanh Toán

                </div>
            </div>
            <div class="right">
                <div class="return_tocard"><a href="<%=(isDispatched == true ? "" : backPrefixLink)%>index.jsp">Quay lại Trang chủ</a></div>
                <div class="support">

                    <div class="top">Điện Thoại Hỗ Trợ</div>
                    <div class="bottom"><a class="phone" href="tel:0123.456.789">0123.456.789</a></div>

                </div>
            </div>
        </div>
        <script src="https://kit.fontawesome.com/10f67b910e.js" crossorigin="anonymous"></script>



    </body>
</html>
