<%-- 
    Document   : index
    Created on : Dec 16, 2021, 12:15:21 AM
    Author     : DELL
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/usermanager/showbill/style.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <%
            Integer cid = (Integer) session.getAttribute("user");
            if (cid != null) {
                ResultSet rsBill = (ResultSet) request.getAttribute("rsBill");
                if (rsBill.next()) {%>
        <h4>Đơn hàng của tôi</h4>
        <div class="bill">
            <div class="bar_bill">
                <div class="oid">Mã đơn hàng</div>
                <div class="datecreate">Ngày Mua</div>
                <div class="pnames">Sản phẩm</div>
                <div class="total">Tổng tiền</div>
                <div class="status">Trạng thái đơn hàng</div>
            </div>
            <div class="bill_list">
                <%rsBill.beforeFirst();
                int i = 0 ;
                    while (rsBill.next()) {
                       String oid =  rsBill.getString("oid");
                       String datecreate = rsBill.getString("datecreate");
                       int total = rsBill.getInt("Total");
                       int curstatus = rsBill.getInt("status");
                       String status = "Đang chờ lấy hàng";
                       if(curstatus==1){
                           status = "Đang đóng gói hàng";
                       }
                       if(curstatus==2){
                           status = "Đang giao hàng";
                       }
                       if(curstatus==3){
                           status = "Đã nhận hàng";
                       }
                      String[] pnames =  (String[])request.getAttribute("pnames");
                      int length_pnames = pnames[i].length();
                %>



                <div class="bill_item">
                    <div class="oid" style="color:blue; cursor:pointer;"><a><%=oid%></a></div>
                    <div class="datecreate"><%=datecreate%></div> 
                    <div class="pnames" style="font-size: <%=(length_pnames>20?10:12)%>px;"><%=pnames[i++]%></div>
                    <div class="total"><%=total%>đ</div>
                    <div class="status"><%=status%></div>

                </div>
               




                <%}%>
            </div>
        </div>
        <%} else {%>
        <div class="nobill">Bạn chưa mua gì</div>
        <%}
        } else {%>
        <jsp:include page="../../error404/index.jsp"/>
        <%}%>
    </body>
</html>
