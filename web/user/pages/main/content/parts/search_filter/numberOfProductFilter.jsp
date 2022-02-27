<%-- 
    Document   : numberOfProductFilter
    Created on : Nov 27, 2021, 2:46:54 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Boolean isDispatched = (Boolean) request.getAttribute("isDispatched");
            if (isDispatched == null) {
                isDispatched = false;
            }
            String uri = request.getRequestURI();
            String pageName = uri.substring(uri.lastIndexOf("/") + 1);
            String[] parts = uri.split("/");
            int numberofSlash = parts.length - 3;
            String backPrefixLink = "";
            while (numberofSlash > 0) {
                backPrefixLink += "../";
                numberofSlash--;
            }

            String cateid = (String) request.getAttribute("cateid");

            String message = (String) request.getAttribute("message");
            String numberofentries = (String) request.getAttribute("numberofentries");

        %>
        <div class="row ml-1">
            <div class="ml-auto mr-3">
                <form class="form-inline md-form entries" action="<%=(isDispatched==true?"":backPrefixLink)%>ControllerProject?action=selectcategory&&url=<%=pageName%>&&cateid=<%=cateid%>&&message=<%=message%>" method="POST">
                    <input class="form-control mr-sm-2" type="text" name="numberofentries"  type="text" placeholder="number of entries" aria-label="Search">
                    <button class="btn aqua-gradient btn-rounded btn-sm my-0" type="submit">Submit</button>
                </form>
            </div>
        </div>
    </body>
</html>
