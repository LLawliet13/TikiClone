<%-- 
    Document   : Login.jsp
    Created on : Oct 13, 2021, 1:43:46 PM
    Author     : DELL
--%>

<%@page import="entity.Admin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <%Boolean isDispatched = (Boolean) request.getAttribute("isDispatched");
            if (isDispatched == null) {
                isDispatched = false;
            }
            String uri = request.getRequestURI();
            String pageName = uri.substring(uri.substring(uri.indexOf("/") + 1).indexOf("/") + 1);
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
        <link href="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/login/loginstyles.css" rel="stylesheet" type="text/css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    </head>

    <body>


        <%  String urlJSP = request.getParameter("url");
            if (urlJSP == null) {
                urlJSP = (String) request.getAttribute("url");
            }
            String massage = (String) request.getAttribute("massage");
            Integer isLogin = (Integer) session.getAttribute("user");

            if (urlJSP == null) {
                urlJSP = (isDispatched == true ? "" : backPrefixLink) + "index.jsp";
            }

        %>

        <%if (isLogin == null) {%>

    <body>

        <div class="container">
            <form id = "loginForm" action="<%=(isDispatched == true ? "" : backPrefixLink)%>ControllerProject?action=userlogin" url="<%=urlJSP%>" method="POST" >
                <h2>Welcome</h2>
                <div class="input-group">
                    <input type="text" id="username" name="username" required>
                    <label for="username">Username</label>
                </div>
                <div class="input-group">
                    <input type="password" id="password" name="password" required>
                    <label for="password">Password</label>
                </div>


                <button type="submit" name="submit" value="submit" >Login</button>
                <p>Don't have account? <a href="">Sign up</a></p>

                <div>
                    <div id="massage"><img src="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/login/image/loading.gif" style="width: 100px;" id="loading" class="hide">
                        <div id="in_massage" style="color:red;"></div>
                    </div>
                </div>

            </form>
                    <div class="logo" style="opacity:0.8"><img src="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/main/nav/image/pngegg.png" alt=""></div>
        </div>

        <script src="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/login/js/ajax/main.js"></script>


        <%} else {

                response.sendRedirect(urlJSP);
            }%>
    </body>
</html>
