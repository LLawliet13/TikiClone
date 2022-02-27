<%-- 
    Document   : index
    Created on : Dec 14, 2021, 10:37:04 PM
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
        String uri = request.getRequestURI();
        String pageName = uri.substring((uri.substring(uri.indexOf("/") + 1)).indexOf("/") + 2);
        String[] parts = uri.split("/");
        int numberofSlash = parts.length-3;
        String backPrefixLink = "";
        while(numberofSlash>0){
        backPrefixLink+="../";
        numberofSlash--;
        }%>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/checkout/footer/style.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <footer>
            <div class="title">Bằng việc tiến hành Đặt Mua, khách hàng đồng ý với các Điều Kiện Giao Dịch Chung được ban hành bởi L</div>
            <div class="rules"><a>Quy chế hoạt động</a><a>Chính sách giải quyết khiếu nại</a><a>Chính sách bảo hành</a><a>Chính sách bảo mật thanh toán</a><a>Chính sách bảo mật thông tin cá nhân</a></div>
            <div class="copyright">© 2021 - Bản quyền của Công Ty Cổ Phần L</div>
        </footer>

    </body>
</html>
