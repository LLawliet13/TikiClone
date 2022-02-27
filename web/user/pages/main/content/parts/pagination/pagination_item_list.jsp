<%-- 
    Document   : index
    Created on : Nov 27, 2021, 2:53:24 PM
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

        <%  Boolean isDispatched = (Boolean) request.getAttribute("isDispatched");
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

            Integer NumbOfPage = (Integer) request.getAttribute("numbofpage");//number of page
            String currentpage = (String) request.getAttribute("currentpage");// current page

            String message = (String) request.getAttribute("message");
            String numberofentries = (String) request.getAttribute("numberofentries");

        %>


        <%if (NumbOfPage != null && NumbOfPage != 0) {
                int num = NumbOfPage;
        %>
        <div class="row ml-1">
            <div class="ml-auto mr-3">
                <nav aria-label="Search results pages" class="pages">
                    <ul class="pagination flex-wrap">

                        <%  int i = 1;

                            while (i <= num) {%>
                        <%
                            if (Integer.parseInt(currentpage) == i) {%>
                        <li class="page-item active">
                            <a class="page-link" href="#"> <%=i%> <span class="sr-only">(current)</span></a>
                        </li>

                        <%} else {%>
                        <li class="page-item"><a class="page-link" href="<%=(isDispatched==true?"":backPrefixLink)%>ControllerProject?action=selectcategory&&cateid=<%=cateid%>&&currentpage=<%=i%>&&urljsp=<%=pageName%>&&message=<%=message%>&&numberofentries=<%=numberofentries%>"><%=i%></a></li>

                        <%}
                                i++;
                            }%>

                    </ul>
                </nav>
            </div>
        </div>
        <%}%>
    </body>
</html>
