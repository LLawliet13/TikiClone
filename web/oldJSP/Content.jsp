<%-- 
    Document   : Item_list
    Created on : Oct 11, 2021, 1:55:05 PM
    Author     : DELL
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Item List</title>

        <link href="css/itemliststyle.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">


    </head>


    <body>


        <%  String uri = request.getRequestURI();
            String pageName = uri.substring(uri.lastIndexOf("/") + 1);
            ResultSet rs = (ResultSet) request.getAttribute("rsPro");//danh sách sản phẩm in ra
            String cateid = (String) request.getAttribute("cateid");

            Integer NumbOfPage = (Integer) request.getAttribute("numbofpage");//number of page
            String currentpage = (String) request.getAttribute("currentpage");// current page
            if (rs == null) {
                response.sendRedirect("../ControllerProject?action=selectcategory&&urljsp=project/" + pageName);
            } else {

        %>





        <% if (pageName.equals("Content.jsp")) {%>
        <div class="link">
            <a href="ControllerProduct?action=insert">insert product</a>
            <a href="ControllerBill">Show Bill</a>
        </div>
        <%}%>
        

        <table class="table w-auto">
            <thead class="thead-light">

            <th scope="col">pname</th>

            <th scope="col">price</th>
            <th scope="col">image</th>
            <th scope="col">description</th>


            <th scope="col">Cart</th>

        </thead> <tbody>  
            <%while (rs.next()) {%>
            <%if (rs.getInt("quantity") >= 0) {%>
            <tr>


                <td><%=rs.getString("pname")%></td>

                <td><%=rs.getDouble("price")%></td>
                <td><img src="<%=rs.getString("Image")%>" width="100px" height="100px"/>
                </td>
                <td><%=rs.getString("description")%></td>



                <td><a href="<%="ControllerProduct_Cart?action=addtocart&&pid=" + rs.getString("pid")%>&&url=project/ShowCartProject.jsp">Add To Cart</a></td>


            </tr>
            <%}%>
            <%}%>
        </tbody>
    </table>
    <%if (NumbOfPage != null) {
            int num = NumbOfPage;
    %>

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
            <li class="page-item"><a class="page-link" href="ControllerProject?action=selectcategory&&cateid=<%=cateid%>&&currentpage=<%=i%>&&urljsp=project/<%=pageName%>"><%=i%></a></li>

            <%}
                    i++;
                }%>

        </ul>
    </nav>
    <%}%>
    <%}%>



</body>


</html>
