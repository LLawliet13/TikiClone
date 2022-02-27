<%-- 
    Document   : ViewBill
    Created on : Oct 6, 2021, 10:55:30 PM
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

        <link href="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/checkout/style.css" rel="stylesheet" type="text/css">
        <script src="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/checkout/main.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

    </head>

    <body>

        <%
            ResultSet cusInfo = (ResultSet) request.getAttribute("cusInfo");
            ResultSet rsCart = (ResultSet) request.getAttribute("rsCart");
            Integer cid = (Integer) session.getAttribute("user");
            if (cid == null) {
                request.getRequestDispatcher((isDispatched == true ? "" : backPrefixLink) + "user/pages/login/index.jsp").forward(request, response);

            } else {

                if (rsCart == null) {
                    response.sendRedirect((isDispatched == true ? "" : backPrefixLink) + "ControllerProject?action=getcheckout&&cid=" + cid);
                } else {

        %>

        <jsp:include page="nav/index.jsp"/>

        <div class="checkout">
            <div class="selectBoard_parent">
                <div class="selectBoard">
                    <div class="deliver_type">
                        <div class="title">1.Chọn hình thức giao hàng</div>
                        <div class="select_list">
                            <div class="option_1 option"><input type="radio" name="delivertype" id="delivertype_1" value="1" /><label for="delivertype_1"><img src="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/checkout/image/fastdelivery.png" alt="fast_deliver" style="width: 50px;"/><span class="detail">Giao Hàng Nhanh</span></label></div>


                        </div>
                        <div class="product_list">
                            <%
                                while (rsCart.next()) {

                            %>
                            <div class="product_item">
                                <div class="product_info">
                                    <img src="<%=rsCart.getString("image")%>" alt="hình ảnh sản phẩm">
                                    <div class="name_quantity_price">
                                        <div class="name"><%=rsCart.getString("pname")%></div>
                                        <div class="quantity_price">
                                            <div class="quantity">SL:<%=rsCart.getInt("quantity")%></div>
                                            <div class="price"><%=rsCart.getInt("quantity") * rsCart.getInt("price")%>đ</div>
                                        </div>


                                    </div>

                                </div>
                                <div class="product_deliverdetail">
                                    <div class="delivery_info">
                                        <div class="delivery_estimatedTime"  style="color: green; font-size:16px; font-weight: bolder; ">Giao vào Thứ N, dddd/mm/yy</div>
                                        <div class="delivery_method">Chuyển Phát bởi Team L Logistic</div>
                                    </div>
                                    <div class="deliver_price" style="color: green;">Miễn Phí</div>
                                </div>


                            </div>

                            <%}%>
                        </div>
                    </div>
                    <div class="payment">
                        <div class="title">2.Chọn hình thức thanh toán</div>
                        <div class="select_list">
                            <div class="option_2 option"><input type="radio" name="paytype" id="paytype_1" value="1" /><label for="paytype_1"><img class="method-icon" width="32" src="https://frontend.tikicdn.com/_desktop-next/static/img/icons/checkout/icon-payment-method-cod.svg" alt="cod"><span>Thanh Toán tiền mặt khi nhận Hàng</span></label></div>
                            <div class="option_2 option"><input type="radio" name="paytype" id="paytype_2" value="2" /><label for="paytype_2"><img class="method-icon" width="32" src="https://frontend.tikicdn.com/_desktop-next/static/img/icons/checkout/icon-payment-method-viettelpay.png" alt="viettelpay"><span class="detail">Thanh toán bằng ViettelPay</span></label></div>
                            <div class="option_2 option"><input type="radio" name="paytype" id="paytype_3" value="3" /><label for="paytype_3"><img class="method-icon" width="32" src="https://frontend.tikicdn.com/_desktop-next/static/img/icons/checkout/icon-payment-method-momo.svg" alt="momo"><span class="detail">Thanh toán bằng ví MoMo</span></label></div>
                            <div class="option_2 option"><input type="radio" name="paytype" id="paytype_4" value="4" /><label for="paytype_4"><img class="method-icon" width="32" src="https://frontend.tikicdn.com/_desktop-next/static/img/icons/checkout/icon-payment-method-zalo-pay.svg" alt="zalopay"><span class="detail">Thanh toán bằng ví ZaloPay</span></label></div>
                            <div class="option_2 option"><input type="radio" name="paytype" id="paytype_5" value="5" /><label for="paytype_5"><img class="method-icon" width="32" src="https://frontend.tikicdn.com/_desktop-next/static/img/icons/checkout/icon-payment-method-atm.svg" alt="pay123"><span class="detail">Thanh toán bằng ví thẻ nội địa</span></label></div>
                        </div>

                    </div>

                </div>
                        <div class="confirm" style="width:550px;" ><input type="checkbox" name="confirm" value="agree" id="confirm_1"/><label for="confirm_1" style="display:block; margin-right:5px;">Xác nhận đồng ý với các điều khoản giao dịch </label> <a style="color:blue;text-decoration: none; cursor:pointer;">(điều khoản giao dịch)</a></span></div>
                <div class="btn buy" onclick="buy(<%=cid%>)" >Đặt Mua</div>
            </div>
            <div>
                <div class="detailBoard">
                    <%cusInfo.next();%>
                    <div class="addressboard">
                        <div class="top">
                            <div class="left" onclick="changeaddress(this)" src="ControllerProject?action=changeaddresscheckout&&cid=<%=cid%>&&index=1">Địa chỉ nhận hàng</div>
                            <div class="right change">Sửa</div>
                        </div>
                        <div class="bottom">
                            <div class="left">
                                <div class="name"><%=cusInfo.getString("cname")%></div> 
                                <div class="address"><%=cusInfo.getString("caddress")%></div> 
                                <div class="phone"><%=cusInfo.getString("cphone")%></div> 

                            </div>
                        </div>



                    </div>
                    <div class="voucher_discount">
                        <div class="top">
                            <div class="left"> Khuyến Mãi </div>
                            <div class="right">có thể chọn n</div>
                        </div>
                        <div class="bottom">
                            <div class="left"><a><img src="https://frontend.tikicdn.com/_desktop-next/static/img/mycoupon/coupon_icon.svg"> Chọn hoặc nhập khuyến mãi</a></div>
                        </div>
                    </div>
                    <div class="cartDetail">
                        <%
                            rsCart.beforeFirst();
                            int numberOfPros = 0;
                            while (rsCart.next()) {
                                numberOfPros++;
                            }
                        %>

                        <div class="top inside">
                            <div class="left">
                                <div class="">Đơn hàng</div>

                                <div class="opendetail" onclick="opendetail()"><%=numberOfPros%> sản phẩm(xem chi tiết)</div>
                            </div>
                            <div class="right change"><a href="<%=(isDispatched == true ? "" : backPrefixLink)%>ControllerProject?action=showcart&&cid=<%=cid%>" style="color:black ; text-decoration: none;">Sửa</a></div>
                        </div>
                        <div class="product_list_2">
                            <%
                                rsCart.beforeFirst();
                                int total = 0;
                                while (rsCart.next()) {
                                    total += rsCart.getInt("quantity") * rsCart.getInt("price");
                            %>

                            <div class="product">

                                <div class="left">

                                    <span><%=rsCart.getInt("quantity")%> X </span><span><a><%=rsCart.getString("pname")%></a></span>
                                    <div>Cung cấp bởi shop nào đó</div>
                                </div>
                                <div class="right"><%=rsCart.getInt("quantity") * rsCart.getInt("price")%>đ</div>

                            </div>
                            <%}%>
                        </div>

                        <div class="bottom">
                            <div class="line">
                                <div class="left">Tạm Tính</div>
                                <div class="right"><%=total%>đ</div>

                            </div>
                            <div class="line">
                                <div class="left">Phí vận chuyển</div>
                                <div class="right">0đ</div>

                            </div>
                            <div class="line">
                                <div class="left">Thành Tiền</div>
                                <div class="right"><%=total%>đ</div>

                            </div>

                        </div>
                    </div>

                </div>
            </div>

        </div>



        <jsp:include page="footer/index.jsp"/>
        <%}%>
        <%}%>
        <script src="https://unpkg.com/sweetalert2@7.8.2/dist/sweetalert2.all.js"></script>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    </body>
</html>
