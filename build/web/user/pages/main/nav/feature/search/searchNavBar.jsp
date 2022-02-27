<%-- 
    Document   : searchNavBar
    Created on : Nov 28, 2021, 2:43:02 PM
    Author     : DELL
--%>

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
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>



    </head>
    <body>
        <form action="">
            <div class="search">
                <input type="text" class="search_input" onkeyup="recommendFunction(this)" onkeydown="endRecommendFunction()" placeholder="Tìm sản phẩm, danh mục hay thương hiệu mong muốn ...">

                <button class="search_button"><i class="fas fa-search " id="search_icon"> </i> Tìm Kiếm</button>
                <div class="recommend" id="recommendNav">
<!--                    <h4>Gợi ý 1</h4>
                    <h4>Gợi ý 2</h4>
                    <h4>Gợi ý 3</h4>
                    <h4>Gợi ý 4</h4>-->

                </div>

            </div>
        </form>
    </body>
</html>
