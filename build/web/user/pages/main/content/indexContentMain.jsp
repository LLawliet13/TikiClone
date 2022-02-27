<%-- 
    Document   : index
    Created on : Nov 27, 2021, 3:40:57 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
    </head>
    <body>
        <jsp:include page="parts/menu/Menu.jsp"/>
        <%--<jsp:include page="parts/search_filter/SearchProduct.jsp"/>--%>
        <%--<jsp:include page="parts/search_filter/numberOfProductFilter.jsp"/>--%>
        <jsp:include page="parts/ads/topic_ads/index.jsp"/>
        <jsp:include page="parts/list_item/hot_item_by_time/index.jsp"/>
        <jsp:include page="parts/list_item/index.jsp"/>
        <%--<jsp:include page="parts/pagination/pagination_item_list.jsp"/>--%>
        
   
    </body>
</html>
