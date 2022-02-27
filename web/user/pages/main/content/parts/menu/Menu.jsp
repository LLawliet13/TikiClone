<%-- 
    Document   : Menu_Project
    Created on : Oct 19, 2021, 3:16:37 AM
    Author     : DELL
--%>

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
            }%>
        <link href="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/main/content/parts/menu/style.css" rel="stylesheet" type="text/css">
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://kit.fontawesome.com/10f67b910e.js" crossorigin="anonymous"></script>
        <style>
            .header{
                margin: 0;
            }
        </style>
    </head>

    <body>

        <%

            ResultSet rsCate = (ResultSet) request.getAttribute("rscate");

            String cateid = (String) request.getAttribute("cateid");

            if (rsCate == null) {

                response.sendRedirect((isDispatched == true ? "" : backPrefixLink) + "ControllerProject?url=" + pageName);

            }
        %>




        <%if (rsCate != null) {
                String numberofentries = (String) request.getAttribute("numberofentries");

        %>

        <%            Integer numbOfCate = (Integer) request.getAttribute("numbOfCate");

        %>
     
        <div class="menu" >
            
            <div class="major-parent-box "  >
                <a class="prev hide " onclick="plusSlides(-1)">&#10094;</a>
                <a class="next " onclick="plusSlides(1)">&#10095;</a>
                <div class="parent-box" style="width: <%=1016*2%>px;">

                    <% while (rsCate.next()) {%>
                    <div class="siblings" style="width: <%=(int) 1016*2/numbOfCate %>px;">
                        <span class="<%if (cateid.equals(rsCate.getInt("cateid") + "")) {%>active<%}%>"><a href="<%=(isDispatched == true ? "" : backPrefixLink)%>ControllerProject?action=selectcategory&&cateid=<%=rsCate.getInt("cateid")%>&&urljsp=<%= pageName%>&&numberofentries=<%=numberofentries%>">
                                <%=rsCate.getString("catename")%></a></span>
                    </div>
                    <%}%>
                </div>
            </div>

            <%}%>
          
            <script src="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/main/content/parts/menu/js/main.js"></script>
        </div>
    </body>
</html>
