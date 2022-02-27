<%-- 
    Document   : index
    Created on : Dec 13, 2021, 10:51:26 PM
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/usermanager/style.css" rel="stylesheet" type="text/css">
        <script src="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/usermanager/main.js"></script>
    </head>
    <body>
        <%
            Integer cid = (Integer) session.getAttribute("user");
            String content_page = request.getParameter("page");
            String content_tag = "";

            if (cid != null) {

                if (content_page.equals("showbill")) {
                    content_tag = "Đơn hàng của tôi";
                }
                if (content_page.equals("showuserinfo")) {
                    content_tag = "Đơn hàng của tôi";
                }
                if (content_page.equals("showbilldetail")) {
                    content_tag = "Chi tiết đơn hàng";
                }

        %>

        <jsp:include page="../main/nav/index.jsp"/>
        <div class="bar_path"><span>Trang chủ</span> <span><svg width="6" height="11" viewBox="0 0 6 11" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill="#808089" fill-rule="evenodd" clip-rule="evenodd" d="M0.646447 0.646447C0.841709 0.451184 1.15829 0.451184 1.35355 0.646447L6.35355 5.64645C6.54882 5.84171 6.54882 6.15829 6.35355 6.35355L1.35355 11.3536C1.15829 11.5488 0.841709 11.5488 0.646447 11.3536C0.451184 11.1583 0.451184 10.8417 0.646447 10.6464L5.29289 6L0.646447 1.35355C0.451184 1.15829 0.451184 0.841709 0.646447 0.646447Z"></path></svg></span> <span id="content_tag"><%=content_tag%></span></div>
        <div class="manager">
            <div class="sidebar">
                <div class="title"></div>
                <div class="card <%if (content_page.equals("showuserinfo")) {%>active-card<%}%>" name="showuserinfo" onclick="opencard(this, 'Thông tin tài khoản')" src="<%=(isDispatched == true ? "" : backPrefixLink)%>ControllerProject?action=showbilltest&&content=userinfo&&cid=<%=cid%>" originalLink="<%=(isDispatched == true ? "" : backPrefixLink)%>ControllerProject?action=usermanager&&cid=<%=cid%>&&page=showuserinfo"><a><svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 24 24" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"></path></svg><span>Thông tin tài khoản</span></a></div>
                <div class="card <%if (content_page.equals("showbilldetail")) {%>active-card<%}%>" name="showbilldetail" onclick="" src="ControllerProject?action="><a><svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 24 24" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z"></path></svg><span>Sổ địa chỉ</span></a></div>
                <div class="card <%if (content_page.equals("showbill")) {%>active-card<%}%>"  name="showbill" onclick="opencard(this, 'Đơn hàng của tôi')" src="<%=(isDispatched == true ? "" : backPrefixLink)%>ControllerProject?action=showbilltest&&content=showbill&&cid=<%=cid%>" originalLink="<%=(isDispatched == true ? "" : backPrefixLink)%>ControllerProject?action=usermanager&&cid=<%=cid%>&&page=showbill"><a><svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 24 24" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M13 12h7v1.5h-7zm0-2.5h7V11h-7zm0 5h7V16h-7zM21 4H3c-1.1 0-2 .9-2 2v13c0 1.1.9 2 2 2h18c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 15h-9V6h9v13z"></path></svg><span>Đơn hàng của tôi</span></a></div>

            </div>
            <div class="content">

                <%if (content_page.equals("showbill")) {%>
                <jsp:include page="showbill/index.jsp"/>
                <%}%>
                <%if (content_page.equals("showuserinfo")) {%>
                <jsp:include page="userInfo/index.jsp"/>
                <%}%>
                <%if (content_page.equals("showbilldetail")) {%>
                <jsp:include page="showbill/index.jsp"/>
                <%}%>

            </div>
        </div>
        <jsp:include page="../main/footer/index.jsp"/>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <%} else {%>
        <jsp:include page="../error404/index.jsp"/>
            <%}%>

         <script src="https://unpkg.com/sweetalert2@7.8.2/dist/sweetalert2.all.js"></script>

    </body>
</html>
