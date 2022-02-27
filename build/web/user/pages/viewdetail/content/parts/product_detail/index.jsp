<%-- 
    Document   : index
    Created on : Dec 5, 2021, 11:13:33 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .container{
                display: flex;
                justify-content: space-around;
            }
        </style>
    </head>


    <body>

        <jsp:include page="../../../../main/nav/index.jsp"/>
        <div class="container">
            <jsp:include page="parts/product_image/index.jsp"/>
            <jsp:include page="parts/product_buy/index.jsp"/>


        </div>
        <jsp:include page="../../../../main/footer/index.jsp"/>
    </body>
</html>
