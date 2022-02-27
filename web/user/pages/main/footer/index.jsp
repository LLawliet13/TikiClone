<%-- 
    Document   : index
    Created on : Nov 27, 2021, 3:47:49 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
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

        %>
        <link rel="stylesheet" href="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/main/footer/style.css">
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <style>
            footer{
                margin-top:30px;
            }
        </style>
    </head>
    <body>
        <footer>
            <div class="support"><h1>Hỗ trợ</h1><p>Hotline:<a class="phone" href="tel:0999.999.999">0999.999.999</a></p></div>
            <div><h1>Về L</h1><a href="">giới thiệu</a><a href="">Chính sách bảo mật</a></div>
            <div><h1>Hình thức thanh toán</h1></div>
            <div><h1>Kết nối với chúng tôi</h1></div>
        </footer>


    </body>
</html>
