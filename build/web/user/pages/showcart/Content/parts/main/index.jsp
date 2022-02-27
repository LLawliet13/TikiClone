<%-- 
    Document   : ShowCart
    Created on : Oct 20, 2021, 1:59:45 PM
    Author     : DELL
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="entity.Product"%>
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://unpkg.com/sweetalert2@7.8.2/dist/sweetalert2.all.js"></script>
        <link href="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/showcart/Content/parts/main/style.css" rel="stylesheet" type="text/css">

    </head>
    <body>  
        <% Integer cid = (Integer) session.getAttribute("user");
            if (cid == null) {
                response.sendRedirect((isDispatched == true ? "" : backPrefixLink) + "user/pages/login/index.jsp");
//                out.println(backPrefixLink);
            } else {
        %>
        <div class="showcart_page">

            <h4>Giỏ Hàng</h4>
            <div class="cart_page">
                <%  ResultSet rs = (ResultSet) request.getAttribute("rsPro");
                    Boolean isEmpty = (Boolean) request.getAttribute("isEmpty");
                    if (isEmpty == null) {%>
                <div class="empty"><img src="https://salt.tikicdn.com/desktop/img/mascot@2x.png" alt="" class="empty__img"><p class="empty__note">Không có sản phẩm nào trong giỏ hàng của bạn.</p><a data-view-id="cart_empty_continue.shopping" href="index.jsp" class="empty__btn">Tiếp tục mua sắm</a></div>

                <%} else {
                    boolean allisInChoose = (Boolean) request.getAttribute("allisInChoose");
                %>
                <div>
                    <div class="cart_bar"><input type="checkbox" name="pid" value="all" onclick="checkAll(this,<%=cid%>)" id="all" <%if (allisInChoose == true) {%>checked<%}%>/><span>Tất cả</span><span>Đơn giá</span><span>Số lượng</span><span>Thành tiền </span><span id="delete" onclick="removeProduct('all',<%=cid%>)"><img src="https://frontend.tikicdn.com/_desktop-next/static/img/icons/trash.svg" alt="deleted" ></span></div>
                    <div id="cart_detail">




                        <%
                            double totalBill = 0;

                            while (rs.next()) {
                                String pid = rs.getString("pid");
                                String image = rs.getString("image");
                                String pname = rs.getString("pname");
                                int quantity = rs.getInt("quantity");
                                int price = rs.getInt("price");
                                double total = rs.getDouble("total");
                                totalBill += total;
                                int discount = rs.getInt("discount");
                                int maxQuantity = rs.getInt("maxquantity");
                                int inchoose = rs.getInt("inchoose");

                        %>



                        <div id="<%=pid%>" class="parts"><input type="checkbox" class="pid" value="<%=pid%>" onclick="checkAll(this,<%=cid%>)" <%if (inchoose == 1) {%>checked<%}%>/>
                            <div class="linkProduct" onclick="openlink(this)" src="ControllerProject?action=viewdetail&&pid=<%=pid%>"><img src="<%=image%>" class="picture"><span><%= pname%></span></div>

                            <div class="price<%=pid%>" price="<%= price%>" discount="<%=discount%>"><%= price%>đ</div>


                            <div class="changeQuantity">
                                <div class="subtract" onclick="subtractQuantity('<%=pid%>',<%=cid%>)"><img
                                        src="https://frontend.tikicdn.com/_desktop-next/static/img/pdp_revamp_v2/icons-remove.svg"
                                        alt=""></div>
                                <input type="text" id="quantity<%=pid%>" pid="<%=pid%>" maxQuantity="<%=maxQuantity%>" cid="<%=cid%>"  value="<%=quantity%>" onblur="Blur('<%=pid%>',<%=cid%>)" onkeyup="this.value = this.value.replace(/[^0-9.]/g, '');"/>
                                <div class="add" onclick="addQuantity('<%=pid%>',<%=cid%>)"><img
                                        src="https://frontend.tikicdn.com/_desktop-next/static/img/pdp_revamp_v2/icons-add.svg"
                                        alt="">
                                </div>

                            </div>
                            <div class="raw_total<%=pid%>"><%=(int) total%>đ</div>
                            <div onclick="removeProduct('<%=pid%>',<%=cid%>)"><img src="https://frontend.tikicdn.com/_desktop-next/static/img/icons/trash.svg" alt="deleted" ></div>

                        </div>

                        <%}%>



                    </div>
                </div>
                <div>
                    <div class="detail">
                        <div class="address">
                            <div class="top">
                                <div class="left">Giao tới</div>
                                <div class="right">thay đổi</div>

                            </div>
                            <div class="bottom"><p>Trần Nguyễn Tiến Dũng | 0328.848.032<p></div>
                        </div>
                        <div class="voucher">
                            <div class="top"><div class="left">Tin khuyến mãi</div>
                                <div class="right">Có thể chọn n</div></div>
                            <div class="bottom">
                                <img src="https://frontend.tikicdn.com/_desktop-next/static/img/mycoupon/coupon_icon.svg"> <a href="#">Chọn hoặc nhập mã khuyến mãi</a></div>
                        </div>


                        <!----------------------------------------------->

                        <%
                            Integer estimateTotal = (Integer) request.getAttribute("estimatedTotal");
                            Integer discountTotal = (Integer) request.getAttribute("discount");
                            Integer Total = (Integer) request.getAttribute("total");
                        %>
                        <div class="buy_detail">
                            <div class="estimated_total top">
                                <div class="left">Tạm Tính</div>
                                <div class="right"><%=estimateTotal%>đ</div>

                            </div>
                            <div class="discount top"><div class="left">Giảm giá</div>
                                <div class="right"><%=discountTotal%>đ</div></div>
                            <div class="real_total top"><div class="left">Tổng cộng</div>
                                <div class="right"><%if (Total != 0) {%><%=Total%>đ<%} else {%>Vui Lòng Chọn Sản Phẩm<%}%></div></div>

                        </div>
                        <div class="buy_btn" src="ControllerProject?action=setcheckout&&cid=<%=cid%>"  onclick="buy(this,<%=cid%>)"><div >Mua hàng</div></div>

                    </div>
                </div>

            



            <script src="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/showcart/Content/parts/main/main.js"></script>
            <%}%>
            </div>
        </div>

        <jsp:include page="../../../../main/footer/index.jsp"/>
        <%}%>

    </body>
</html>
