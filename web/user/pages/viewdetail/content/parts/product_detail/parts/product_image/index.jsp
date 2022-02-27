<%-- 
    Document   : index
    Created on : Dec 5, 2021, 9:27:21 PM
    Author     : DELL
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%Boolean isDispatched = (Boolean) request.getAttribute("isDispatched");
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
        %>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <link rel="stylesheet" href="<%=(isDispatched==true?"":backPrefixLink)%>user/pages/viewdetail/content/parts/product_detail/parts/product_image/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    </head>
    <body>
         <%
            ResultSet rsPro = (ResultSet) request.getAttribute("rsPro");
            if(rsPro!=null){
            rsPro.beforeFirst();
            rsPro.next();
            String image = rsPro.getString("image");
           
        %>
        <div class="product_detail_page">
            <div class="container">
                <div class="image">
                    <img src="<%=image%>"
                         alt="">
                </div>
                <div class="share">
                    <p>chia sẻ:
                        <img src="https://frontend.tikicdn.com/_desktop-next/static/img/pdp_revamp_v2/social-facebook.svg"
                             alt=""><img
                             src="https://frontend.tikicdn.com/_desktop-next/static/img/pdp_revamp_v2/social-messenger.svg"
                             alt=""><img
                             src="https://frontend.tikicdn.com/_desktop-next/static/img/pdp_revamp_v2/social-pinterest.svg"
                             alt=""><img
                             src="https://frontend.tikicdn.com/_desktop-next/static/img/pdp_revamp_v2/social-twitter.svg"
                             alt=""><img
                             src="https://frontend.tikicdn.com/_desktop-next/static/img/pdp_revamp_v2/social-copy.svg"
                             alt="">
                        <span class="seperate"></span>
                        <img src="https://frontend.tikicdn.com/_desktop-next/static/img/pdp_revamp_v2/icons-like.svg" alt="">
                        Thích
                    </p>
                </div>

                <div class="detail"></div>
            </div>

        </div>
                         <%}%>
    </body>
</html>
