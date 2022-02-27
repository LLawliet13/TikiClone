<%-- 
    Document   : index
    Created on : Dec 5, 2021, 9:27:02 PM
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/viewdetail/content/parts/product_detail/parts/product_buy/style.css">
        <script src="https://unpkg.com/sweetalert2@7.8.2/dist/sweetalert2.all.js"></script>

        <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>-->
    </head>
    <body>
        <script src="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/viewdetail/content/parts/product_detail/parts/product_buy/main.js"></script>
        <%
            ResultSet rsPro = (ResultSet) request.getAttribute("rsPro");
            if(rsPro!=null){rsPro.beforeFirst();
            if(rsPro.next()){
            Integer cid = (Integer)session.getAttribute("user");
            String pname = rsPro.getString("pname");
            String pid = rsPro.getString("pid");
            int rate = rsPro.getInt("rate");
            int count = rsPro.getInt("count");
            int discount = rsPro.getInt("discount");
            int price = rsPro.getInt("price");
        %>
        <div class="product_buy_detail">
            <div class="left">
                <div class="name"><%=pname%></div>
                <div class="rate">
                    <%
                        int i = 0;
                        while (i < rate) {
                    %>
                    <i class="fas fa-star"></i>
                    <%i++;
                        }%>

                    <span class="numberOfRates">(n lượt đánh giá)</span>
                    <span class="seperate">|</span>
                    <span class="numberOfProsSold">Đã bán <%=count%></span>
                </div>
                <div class="price">
                    <%=price%> VND
                    <div class="discount">Đang giảm giá <%=discount%>%</div>
                </div>
                <div class="address">Giao đến <a href="">nhà Dũng</a> - <a href="" id="changeAddress">Đổi địa chỉ</a> </div>
                <label for="amount">Số Lượng</label>
                <div class="amount">
                    <button class="subtract" onclick="subtractQuantity()"><img
                            src="https://frontend.tikicdn.com/_desktop-next/static/img/pdp_revamp_v2/icons-remove.svg"
                            alt=""></button>
                    <input type="text" name="quantity"  onkeyup="validateNumber(this)"  value="0" class="quantity" />
                    <!--<span class="quantity">0</span>-->
                    <button class="add" onclick="addQuantity() "><img
                            src="https://frontend.tikicdn.com/_desktop-next/static/img/pdp_revamp_v2/icons-add.svg"
                            alt=""></button>
                </div>
                <div class="choose">
                    <div class="buy" onclick="addtocart(this,<%=cid%>)" pid="<%=pid%>" >Chọn Mua</div>
                    <span class="chat">chat</span>
                </div>
            </div>
            <div class="right">
                <div class="top">
                    <div class="shopName">Kho Hàng Nội Địa</div>
                    <div class="shop_detail">
                        <div class="shopRate">
                            <div class="tp">3/5<i class="fas fa-star"></i></div>
                            <div class="bm">100 lượt</div>
                        </div>
                        <div class="shopFollow">
                            <div class="tp">150</i></div>
                            <div class="bm">Theo dõi</div>
                        </div>
                    </div>
                    <div class="link">
                        <div class="showShop"><img
                                src="https://salt.tikicdn.com/ts/upload/49/27/ff/d735c33edfdc6cf6aeb6e183bec28869.png"
                                alt=""><span>Xem Shop</span></div>
                        <div class="follow"><img
                                src="https://salt.tikicdn.com/ts/upload/5b/bf/3c/eeda00767e26b5873030e44f951441c4.png"
                                alt=""><span>Theo dõi</span></div>
                    </div>
                    <div class="insurance"><span class="ileft">Hướng Dẫn Bảo Hành</span><a href="" class="iright">Xem Chi
                            Tiết</a></div>
                </div>
            </div>
        </div>
                   <%}%> 
                   <%}%> 
        

    </body>
</html>
