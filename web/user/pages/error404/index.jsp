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
        <style>
            *{margin:0;}
            
        </style>
    </head>
    <body>
        <div style="display: flex;align-items: center;height: 100vh;position: relative;justify-content: center">
        <img src="<%=(isDispatched==true?"":backPrefixLink)%>user/image/404notfound-2.png" style="width:50%;display: block; margin:0 auto;">
        <a href="<%=(isDispatched==true?"":backPrefixLink)%>index.jsp" style="position: absolute;bottom:20vh; padding:10px 15px; background-color: #81bffc; border-radius: 5px; color: white;text-decoration: none">Back to home</a>
        </div>
        </body>
</html>
