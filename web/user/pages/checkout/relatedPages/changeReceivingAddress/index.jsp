<%-- 
    Document   : index
    Created on : Dec 15, 2021, 3:56:02 PM
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
        <link href="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/checkout/relatedPages/style.css" rel="stylesheet" type="text/css">

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Integer cid = (Integer) session.getAttribute("cid");
            ResultSet rs = (ResultSet) request.getAttribute("rsReceivingAddress");

            if (cid != null && rs != null) {

        %>

        <jsp:include page="../../nav/index.jsp"/>
        <form action="ControllerProject?action=changeaddresscheckout" method="POST">

            <div class="changeAddress">
                <div class="cusInfo">
                    <div class="name"><%=rs.getString("cname")%></div>
                    <div class="address"><%=rs.getString("caddress")%></div>
                    <div class="phone"><%=rs.getString("cphone")%></div>


                </div>
                <div class="choice">
                    <div class="confirm" onclick="submit(cid)">Xác Nhận</div>
                    <div class="change" onclick="change(cid)">Sửa</div>
                </div>


            </div>
        </form>
        <jsp:include page="../../footer/index.jsp"/>


        <%} else {
                response.sendRedirect((isDispatched == true ? "" : backPrefixLink) + "user/pages/error404/index.jsp");
            }%>

    </body>
</html>
