<%-- 
    Document   : index
    Created on : Dec 12, 2021, 5:06:05 PM
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/main/content/parts/list_item/hot_item_by_time/style.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/main/content/parts/list_item/hot_item_by_time/main.js"></script>
    </head>

    <body>
        <%
            ResultSet rsProTime = (ResultSet) request.getAttribute("rsProTime");
            if (rsProTime != null) {
        %>
        <div class="hot_item_by_time">
            <div class="top">
                <div class="title">
                    <span>Sản Phẩm</span><img  src="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/main/content/parts/list_item/hot_item_by_time/image/hot-icon2_1.gif">
                    <span style="padding:0; padding-top:10px;">Nổi Bật</span>
                </div>
                <div class="filter">
                    <span class="type activeTime"  data="byday" onclick="selectType(this)">Theo Ngày</span><span class="type" data="byweek" onclick="selectType(this)">Theo Tuần</span ><span class="type" data="bymonth" onclick="selectType(this)">Theo Tháng</span>
                </div>
            </div>
            <div class="bottom">
                <div class="parent parent_time" >
                    <a class="prevTime hideTime " data="prev" onclick="plusSlidesTime(-1)">&#10094;</a>
                    <a class="nextTime "  data="next"  onclick="plusSlidesTime(1)">&#10095;</a>
                    <div class="child child_time" style="width: <%=(1120 * 2)%>px;">

                       
                        <%
                            int rsProTimelength = (Integer) request.getAttribute("rsProTimelength");
                            while (rsProTime.next()) {
                                String image = rsProTime.getString("image");
                                int price = rsProTime.getInt("price");
                                int discount = rsProTime.getInt("discount");
                                int sold = rsProTime.getInt("sold");
                                String pid = rsProTime.getString("pid");

                        %>

                        <div class="item" style="width: <%=(int) 1094 * 2 / rsProTimelength%>px;"  onclick="openItem(this)" src="<%=pid%>">
                            <div class="img"><img src="<%=image%>"></div>
                            <div class="price"><span class="price"><%=price%>đ</span>
                                <span class="discount"><%=discount%>%</span>
                            </div>
                            <div class="w3-border sold" style="width: <%=(int) 1094 * 2 / rsProTimelength%>px;">
                                <div class="w3-grey" style="height:24px;width:<%=sold + 5%>%;"></div>
                                <span id="sold_child"><%if (sold == 0) {%>Vừa Mở Bán<%} else {%>đã bán <%=sold%><%}%></span>
                            </div>


                        </div>

                        <%}%>
                    </div>
                </div>

            </div>

        </div>
        <%}%>
        <div class="ads_time">
            <img src="https://salt.tikicdn.com/cache/w200/ts/banner/73/07/35/f54aec682f64e7a1b3af2f155af29ec1.jpg" class="WebpImg__StyledImg-sc-h3ozu8-0 fWjUGo">
            <img src="https://salt.tikicdn.com/cache/w750/ts/banner/78/e3/90/b009a0a7605960256066406b8ea15694.jpg" class="WebpImg__StyledImg-sc-h3ozu8-0 fWjUGo">
            <img src="https://salt.tikicdn.com/cache/w200/ts/banner/8b/10/47/0878b580f141729eb840ed4f6b55ec96.jpg" class="WebpImg__StyledImg-sc-h3ozu8-0 fWjUGo">
        </div>
        <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>-->

        <script src="https://unpkg.com/sweetalert2@7.8.2/dist/sweetalert2.all.js"></script>

    </body>
</html>
