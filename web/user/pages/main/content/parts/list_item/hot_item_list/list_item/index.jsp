<%-- 
    Document   : index
    Created on : Nov 29, 2021, 7:06:57 AM
    Author     : DELL
--%>

<%@page import="java.sql.ResultSet"%>
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
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <link rel="stylesheet" href="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/main/content/parts/list_item/hot_item_list/list_item/style.css">
        <script src="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/main/content/parts/list_item/hot_item_list/list_item/main.js"></script>
    </head>
    <body>
        <%
            ResultSet rsHotList = (ResultSet) request.getAttribute("rsPro");
            if (rsHotList != null) {
        %>

        <div class="hot_item_list" >
            <%
                int index = 0;
                while (rsHotList.next()) {
                    index = 0;
            %>
            <div class="hot_item_list_row" >

                <%do {
                %>


                <div class="product_card">
                    <div class="product_pic"><img class="product_image" src="<%=rsHotList.getString("image")%> " alt="Product image"></div>
                    <p><%=rsHotList.getString("pname")%></p>

                    <div class="product_info">
                        <div class="product_feedback" >
                            <div class="product_rate"><% int i = 0;
                                while (i < 5) {%><i class="fas fa-star"></i><%i++;
                                    }%></div>|<div class="number_product_sold">đã bán 100</div>
                        </div>
                        <div class="product_price">
                            <div class="raw_price">
                                <%=rsHotList.getInt("price")%>₫
                            </div>
                            <div class="discount">-30%</div>
                        </div>


                    </div>
                    <div class="view_product" onclick="openDetail(this)" request="ControllerProject?action=viewdetail&&pid=<%=rsHotList.getString("pid")%>">Xem Chi Tiết</div>
                </div>

                <%index++;

                    } while (index < 6 && rsHotList.next());%>
            </div>
            <%}%>

        </div>
        <div class="viewmore" onclick="showMore()">
            <h1>Xem Thêm</h1>
        </div>
        <%}%>



    </body>
</html>
