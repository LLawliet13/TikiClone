<%-- 
    Document   : CheckOut
    Created on : Oct 11, 2021, 4:51:22 PM
    Author     : DELL
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="entity.Product"%>
<%@page import="java.util.Enumeration"%>
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
            Enumeration all = session.getAttributeNames();
            ResultSet cusSet = (ResultSet) request.getAttribute("rs");
            String user = (String) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("Login.jsp?url=CheckOut.jsp");
            }

        %>
        <!--<a href="ControllerAdmin?action=login&&url=/CheckOut.jsp">Login</a>-->


        <jsp:include page="ShowCartProject.jsp"/>
        <form  class="form-inline" action="ControllerProduct_Cart?action=search&&url=/CheckOut.jsp" method="POST">


            <input class="form-control mr-sm-2" type="text" name="cname" value="" placeholder="Customer Name" aria-label="Search">

            <!--                        <select name="sortby">
                                    <option></option>
                                    </select>-->

            <button class="btn btn-outline-success my-2 my-sm-0" type="submit" value="search" name="search">Search</button>

        </form> 
        <br>




        <%if (cusSet != null) {%>

        <table class="table w-auto">


            <thead class="thead-light">
                
                    <th scope="col" >cid</th>
                    <th scope="col" >cname</th>
                    <th scope="col" >cphone</th>
                    <th scope="col" >cAddress</th>
                    <th scope="col" >Status</th>
                    <th scope="col" >Username</th>
                    <th scope="col" >Select</th>
               
            </thead>
            <% int cid = -1;%>
            <!--lưu cid user chọn-->
        </tbody>
        <% while (cusSet.next()) {%>
        <tr>
            <td><%=cusSet.getInt("cid")%></td>
            <td><%=cusSet.getString("cname")%></td>
            <td><%=cusSet.getString("cphone")%></td>
            <td><%=cusSet.getString("caddress")%></td>
            <td><%=cusSet.getInt("status") == 1 ? "enable" : "disable"%></td>
            <td><%=cusSet.getString("username")%></td>
            <td>
            <%if (cusSet.getInt("status") == 1) {%>
            <a href="ControllerProduct_Cart?action=createbillform&&cid=<%=cusSet.getInt("cid")%>">Select</a>
            <%}%>
            </td>


        </tr>
        <%}
            }%>
    </table>





</body>
</html>
