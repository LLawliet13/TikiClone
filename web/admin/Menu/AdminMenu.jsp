<%-- 
    Document   : AdminMenu
    Created on : Oct 24, 2021, 11:13:45 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    </head>
    <body>
        <%
            String managerType = (String) request.getAttribute("managertype");
            String menuindex = "";
            if (managerType == null) {
                menuindex = "";
            } else {
                menuindex = managerType;
            }
        %>
        <%
            Boolean isDispatched = (Boolean) request.getAttribute("isDispatched");
            if(isDispatched==null){
                isDispatched = false;
            }
            String customerHref = "";
            String productHref = "";
            String billHref = "";
            if (isDispatched == false) {
                
                customerHref = "../ControllerProject?action=selectmanager&&managertype=customermanager&&option=showoption";
                productHref = "../ControllerProject?action=selectmanager&&managertype=productmanager&&option=showoption";
                billHref = "../ControllerProject?action=selectmanager&&managertype=billmanager&&option=showoption";
            } else {
                customerHref = "ControllerProject?action=selectmanager&&managertype=customermanager&&option=showoption";
                productHref = "ControllerProject?action=selectmanager&&managertype=productmanager&&option=showoption";
                billHref = "ControllerProject?action=selectmanager&&managertype=billmanager&&option=showoption";
            }
        %>
        <ul class="list-group">
            <li class="list-group-item active ">Admin Manager</li>
            <li class="list-group-item list-group-item-action <%if (menuindex.equals("customermanager")) {%>list-group-item-info<%}%>"><a href="<%=customerHref%>">Customer Manager</a></li>
            <li class="list-group-item list-group-item-action <%if (menuindex.equals("productmanager")) {%>list-group-item-info<%}%>"><a href="<%=productHref%>">Product Manager</a></li>
            <li class="list-group-item list-group-item-action <%if (menuindex.equals("billmanager")) {%>list-group-item-info<%}%>"><a href="<%=billHref%>">Bill Manager</a></li>





        </ul>
    </body>
</html>
