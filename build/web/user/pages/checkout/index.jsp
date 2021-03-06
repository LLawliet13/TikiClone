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
                        <div class="title">1.Ch???n h??nh th???c giao h??ng</div>
                        <div class="select_list">
                            <div class="option_1 option"><input type="radio" name="delivertype" id="delivertype_1" value="1" /><label for="delivertype_1"><img src="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/checkout/image/fastdelivery.png" alt="fast_deliver" style="width: 50px;"/><span class="detail">Giao H??ng Nhanh</span></label></div>


                        </div>
                        <div class="product_list">
                            <%
                                while (rsCart.next()) {

                            %>
                            <div class="product_item">
                                <div class="product_info">
                                    <img src="<%=rsCart.getString("image")%>" alt="h??nh ???nh s???n ph???m">
                                    <div class="name_quantity_price">
                                        <div class="name"><%=rsCart.getString("pname")%></div>
                                        <div class="quantity_price">
                                            <div class="quantity">SL:<%=rsCart.getInt("quantity")%></div>
                                            <div class="price"><%=rsCart.getInt("quantity") * rsCart.getInt("price")%>??</div>
                                        </div>


                                    </div>

                                </div>
                                <div class="product_deliverdetail">
                                    <div class="delivery_info">
                                        <div class="delivery_estimatedTime"  style="color: green; font-size:16px; font-weight: bolder; ">Giao v??o Th??? N, dddd/mm/yy</div>
                                        <div class="delivery_method">Chuy???n Ph??t b???i Team L Logistic</div>
                                    </div>
                                    <div class="deliver_price" style="color: green;">Mi???n Ph??</div>
                                </div>


                            </div>

                            <%}%>
                        </div>
                    </div>
                    <div class="payment">
                        <div class="title">2.Ch???n h??nh th???c thanh to??n</div>
                        <div class="select_list">
                            <div class="option_2 option"><input type="radio" name="paytype" id="paytype_1" value="1" /><label for="paytype_1"><img class="method-icon" width="32" src="https://frontend.tikicdn.com/_desktop-next/static/img/icons/checkout/icon-payment-method-cod.svg" alt="cod"><span>Thanh To??n ti???n m???t khi nh???n H??ng</span></label></div>
                            <div class="option_2 option"><input type="radio" name="paytype" id="paytype_2" value="2" /><label for="paytype_2"><img class="method-icon" width="32" src="https://frontend.tikicdn.com/_desktop-next/static/img/icons/checkout/icon-payment-method-viettelpay.png" alt="viettelpay"><span class="detail">Thanh to??n b???ng ViettelPay</span></label></div>
                            <div class="option_2 option"><input type="radio" name="paytype" id="paytype_3" value="3" /><label for="paytype_3"><img class="method-icon" width="32" src="https://frontend.tikicdn.com/_desktop-next/static/img/icons/checkout/icon-payment-method-momo.svg" alt="momo"><span class="detail">Thanh to??n b???ng v?? MoMo</span></label></div>
                            <div class="option_2 option"><input type="radio" name="paytype" id="paytype_4" value="4" /><label for="paytype_4"><img class="method-icon" width="32" src="https://frontend.tikicdn.com/_desktop-next/static/img/icons/checkout/icon-payment-method-zalo-pay.svg" alt="zalopay"><span class="detail">Thanh to??n b???ng v?? ZaloPay</span></label></div>
                            <div class="option_2 option"><input type="radio" name="paytype" id="paytype_5" value="5" /><label for="paytype_5"><img class="method-icon" width="32" src="https://frontend.tikicdn.com/_desktop-next/static/img/icons/checkout/icon-payment-method-atm.svg" alt="pay123"><span class="detail">Thanh to??n b???ng v?? th??? n???i ?????a</span></label></div>
                        </div>

                    </div>

                </div>
                        <div class="confirm" style="width:550px;" ><input type="checkbox" name="confirm" value="agree" id="confirm_1"/><label for="confirm_1" style="display:block; margin-right:5px;">X??c nh???n ?????ng ?? v???i c??c ??i???u kho???n giao d???ch </label> <a style="color:blue;text-decoration: none; cursor:pointer;">(??i???u kho???n giao d???ch)</a></span></div>
                <div class="btn buy" onclick="buy(<%=cid%>)" >?????t Mua</div>
            </div>
            <div>
                <div class="detailBoard">
                    <%cusInfo.next();%>
                    <div class="addressboard">
                        <div class="top">
                            <div class="left" onclick="changeaddress(this)" src="ControllerProject?action=changeaddresscheckout&&cid=<%=cid%>&&index=1">?????a ch??? nh???n h??ng</div>
                            <div class="right change">S???a</div>
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
                            <div class="left"> Khuy???n M??i </div>
                            <div class="right">c?? th??? ch???n n</div>
                        </div>
                        <div class="bottom">
                            <div class="left"><a><img src="https://frontend.tikicdn.com/_desktop-next/static/img/mycoupon/coupon_icon.svg"> Ch???n ho???c nh???p khuy???n m??i</a></div>
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
                                <div class="">????n h??ng</div>

                                <div class="opendetail" onclick="opendetail()"><%=numberOfPros%> s???n ph???m(xem chi ti???t)</div>
                            </div>
                            <div class="right change"><a href="<%=(isDispatched == true ? "" : backPrefixLink)%>ControllerProject?action=showcart&&cid=<%=cid%>" style="color:black ; text-decoration: none;">S???a</a></div>
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
                                    <div>Cung c???p b???i shop n??o ????</div>
                                </div>
                                <div class="right"><%=rsCart.getInt("quantity") * rsCart.getInt("price")%>??</div>

                            </div>
                            <%}%>
                        </div>

                        <div class="bottom">
                            <div class="line">
                                <div class="left">T???m T??nh</div>
                                <div class="right"><%=total%>??</div>

                            </div>
                            <div class="line">
                                <div class="left">Ph?? v???n chuy???n</div>
                                <div class="right">0??</div>

                            </div>
                            <div class="line">
                                <div class="left">Th??nh Ti???n</div>
                                <div class="right"><%=total%>??</div>

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
