<%-- 
    Document   : index
    Created on : Dec 16, 2021, 6:30:44 PM
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
            }%>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/usermanager/userInfo/main.js"></script>
        <link href="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/usermanager/userInfo/style.css" rel="stylesheet" type="text/css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    </head>
    <body>
        <%
            ResultSet rsCus = (ResultSet) request.getAttribute("rsCus");
            Integer cid = (Integer) session.getAttribute("user");
            if (cid != null && rsCus != null) {
                rsCus.next();
                String cname = rsCus.getString("cname");
                String cphone = rsCus.getString("cphone");
                String cdob = rsCus.getString("cdob");
                Integer csex = rsCus.getInt("csex");
                String cemail = rsCus.getString("cemail");
                String caddress = rsCus.getString("caddress");

        %>
        <div class="user-info">
            <div class="basic-info"><h4>Thông tin cá nhân</h4>
                <div class="info-table">
                    <form action="<%=(isDispatched == true ? "" : backPrefixLink)%>ControllerProject?action=changeuserinfo&&cid=<%=cid%>"  id="changedetail" method="POST">
                        <div><span>Họ & Tên</span><input type="text" name="cname" value="<%=cname%>" placeholder="Thêm Họ và Tên" /></div>
                        <div><span>Ngày Sinh</span><input type="date" name="cdob" value="<%=cdob%>" placeholder="Thêm ngày sinh"/></div>
                        <div><span>Địa chỉ</span><input type="text" name="caddress" value="<%=caddress%>" placeholder="Thêm địa chỉ"/></div>
                        <div class="csex"><span>Giới tính</span><div class="csex inner-csex"><input type="radio" name="csex" value="1" <%if (csex == 1) {%>checked<%}%> /><span>Nam</span><input type="radio" name="csex" value="0" <%if (csex == 0) {%>checked<%}%> /><span>Nữ</span> </div></div>
                        <div class="btn"><span></span><input type="submit" value="Lưu thay đổi" name="submit" onclick="submitForm()"/></div>

                    </form>

                </div>

            </div>
            <div class="contact-info">
                <h4>Số điện thoại và Email</h4>
                <div class="contact-table">
                    <div class="cphone">
                        <div class="left">
                            <div class="title-inner"><img src="https://frontend.tikicdn.com/_desktop-next/static/img/account/phone.png" class="icon" alt=""><span>Số điện thoại</span></div>
                            <div class="detail"><img><%=cphone%></div>
                        </div>
                        <div class="right">Cập nhật</div>
                    </div>
                    <div class="email">
                        <div class="left">
                            <div class="title-inner"><img src="https://frontend.tikicdn.com/_desktop-next/static/img/account/email.png" class="icon" alt=""><span>Địa chỉ email</span></div>
                            <div class="detail"><img><%=cemail%></div>
                        </div>
                        <div class="right">Cập nhật</div>
                    </div>

                </div>
                <h4>Bảo mật</h4>
                <div class="password"><img src="https://frontend.tikicdn.com/_desktop-next/static/img/account/lock.png" class="icon" alt=""><span>Đổi mật khẩu</span></div>

            </div>
        </div>
        <%}%>



    </body>
</html>
