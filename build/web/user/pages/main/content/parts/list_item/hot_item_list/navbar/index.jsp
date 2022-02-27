<%-- 
    Document   : index
    Created on : Nov 29, 2021, 6:59:06 AM
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
        <link rel="stylesheet" href="<%=(isDispatched==true?"":backPrefixLink)%>user/pages/main/content/parts/list_item/hot_item_list/navbar/style.css">
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
    </head>
    <body>
        <divid id="topHL"></div>
        <div class="hot_topic_bar" >
            <div class="top">Gợi Ý Hôm Nay</div>
            <div class="bottom">
                <div class="box active_hot_list_nav" onclick="selectCategory(this)">
                    <div class="icon"><img src="<%=(isDispatched==true?"":backPrefixLink)%>user/pages/main/content/parts/list_item/hot_item_list/image/hot_deal.png"></div>
                    <p class="detail" topic="hot_deal" >deal siêu hot</p>
                </div>
                <div class="box " onclick="selectCategory(this)">
                    <div class="icon"><img src="<%=(isDispatched==true?"":backPrefixLink)%>user/pages/main/content/parts/list_item/hot_item_list/image/new.png"></div>
                    <p class="detail" topic="newStuffs" >hàng mới</p>
                </div>
                <div class="box" onclick="selectCategory(this)">
                    <div class="icon"><img src="<%=(isDispatched==true?"":backPrefixLink)%>user/pages/main/content/parts/list_item/hot_item_list/image/trend.png"></div>
                    <p class="detail" topic="trend" >xu hướng</p>
                </div>
                
                <div class="box" onclick="selectCategory(this)">
                    <div class="icon"><img src="<%=(isDispatched==true?"":backPrefixLink)%>user/pages/main/content/parts/list_item/hot_item_list/image/discount.png"></div>
                    <p class="detail" topic="big_discount" >giảm tới 50%</p>
                </div>

            </div>
        </div>
        <div class="hot_topic_goods">



        </div>
    </body>
</html>
