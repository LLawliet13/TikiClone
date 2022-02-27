<%-- 
    Document   : Panner
    Created on : Oct 19, 2021, 2:43:09 AM
    Author     : DELL
--%>

<%@page import="model.DBConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <% Boolean isDispatched = (Boolean) request.getAttribute("isDispatched");
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

            Integer user = (Integer) session.getAttribute("user");


        %>
        <link href="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/main/nav/pannerstyle.css" rel="stylesheet" type="text/css">
        <meta charset="UTF-8">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/main/nav/main.js"></script>

        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">


        <style>
            #navBarSearchForm input[type=text]{width:430px !important;}
        </style>

    </head>

    <body>

        <div class="header">
            <div class="left">
                <a href="<%=(isDispatched == true ? "" : backPrefixLink)%>index.jsp" >
                    <img class="logo" src="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/main/nav/image/pngegg.png" alt="logo"></a>
                    <div class="bottom">Your Choices</div></div>
            <div class="center">
                <!-- <nav>
                <ul class="nav_links">
                    <li><a href="">service</a></li>
                    <li><a href="">service</a></li>
                    <li><a href="">service</a></li>
                </ul>
            </nav> -->
                <jsp:include page="feature/search/searchNavBar.jsp"/>

                <div class="dropdown">
                    <button class="user_dropdown">

                        <%if (user != null) {%>
                        <%  DBConnect dao = new DBConnect();
                            ResultSet rs = dao.getData("select * from customer where cid = " + user + "");
                            rs.next();
                        %>
                        <img class="profile-icon" src="https://salt.tikicdn.com/ts/upload/67/de/1e/90e54b0a7a59948dd910ba50954c702e.png">
                        <span><%=rs.getString("cname")%></span>
                        <%} else {%>Tài Khoản <%}%></button>

                    <div class="dropdown-content">
                        <%if (user == null) {%>
                        <a href="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/login/index.jsp?url=<%=pageName%>">Login</a>
                        <a href="<%=(isDispatched == true ? "" : backPrefixLink)%>ControllerCustomer?action=insert&&url=index.jsp&&register=show">Register</a>
                        <%}%>
                        <% if (user != null) {%>
                        <a href="<%=(isDispatched == true ? "" : backPrefixLink)%>ControllerProject?action=usermanager&&cid=<%=user%>&&page=showuserinfo">Thông tin tài khoản</a>
                        <a href="<%=(isDispatched == true ? "" : backPrefixLink)%>ControllerProject?action=usermanager&&cid=<%=user%>&&page=showbill">Đơn hàng của tôi</a>
                        <a href="<%=(isDispatched == true ? "" : backPrefixLink)%>ControllerProject?action=userlogout">Logout</a>
                        <%}%>

                    </div>
                </div>
                <% String cart
                            = //                        "user/pages/showcart/index.jsp";
                            "ControllerProject?action=showcart&&cid="+user;
                    Integer numberOfProduct = 0;
                    if (user == null) {
                        cart = "user/pages/login/index.jsp?url=" + pageName;

                    }

                %>

                <div class="cart">
                    <i class="fas fa-shopping-cart "></i>
                    <a href="<%=(isDispatched == true ? "" : backPrefixLink)%><%=cart%>"><button class="shopping_cart">  Giỏ hàng<span id="cartTB">0</span></button></a>

                </div>
            </div>
        </div>

        <script src="https://kit.fontawesome.com/10f67b910e.js" crossorigin="anonymous"></script>


    </tbody>
</table>
</body>
</html>
