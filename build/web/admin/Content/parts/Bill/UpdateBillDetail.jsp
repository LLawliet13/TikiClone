<%-- 
    Document   : ViewBillDetailProject
    Created on : Oct 21, 2021, 12:55:00 AM
    Author     : DELL
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    </head>
    <body>
        <%ResultSet rsbilldetail = (ResultSet) request.getAttribute("rs");
            Integer status = (Integer) request.getAttribute("statusbill");
            String urlJSP = (String) request.getAttribute("url");// lấy đích đên trang trả về 
            if (urlJSP == null) {
                urlJSP = "AdminSettings.jsp";
            }
        %>
        <% String uri = request.getRequestURI();
            String pathName = uri.substring(uri.lastIndexOf("/") + 1);
            if (urlJSP.equals(pathName)) {
                urlJSP = "AdminSettings.jsp";
            }
        %>

        <%if (status != null) {%>
        <form action="ControllerProject?action=changestatusbill&&url=<%=urlJSP%>" method="POST">
            <div class="form-group row">
                <select class="form-control col-sm-5" id="exampleFormControlSelect1" name="status">
                    <option value="-1" <%if (status == -1) {%>selected="selected"<%}%>>disable</option>
                    <option value="0" <%if (status == 0) {%>selected="selected"<%}%>>wait</option>
                    <option value="1" <%if (status == 1) {%>selected="selected"<%}%>>process</option>
                    <option value="2" <%if (status == 2) {%>selected="selected"<%}%>>done</option>

                </select>
                <input type="hidden" name="oid" value="<%=(String) request.getAttribute("oid")%>" />
                <div class="col-sm-5">
                    <button type="submit" value="submit" name="submit" class="btn btn-primary">Submit</button>
                </div>

            </div>




            <table class="table w-auto">


                <thead class="thead-light">

                <th scope="col" >oid</th>
                <th scope="col" >pid</th>
                <th scope="col" >quantity </th>
                <th scope="col" >price </th>
                <th scope="col" >total</th>
                <th scope="col" >update </th>
                <th scope="col" >delete</th>
                </thead> <tbody>
                    <%while (rsbilldetail.next()) {%>
                    <tr>
                        <td><%=rsbilldetail.getString("oid")%></td>
                        <td><%=rsbilldetail.getString("pid")%></td>
                        <td><%=rsbilldetail.getInt("quantity")%></td>
                        <td><%=rsbilldetail.getDouble("price")%></td>
                        <td><%=rsbilldetail.getDouble("total")%></td>
                        <td><a href="ControllerProject?action=updatebilldetail&&oid=<%=rsbilldetail.getString("oid")%>&&pid=<%=rsbilldetail.getString("pid")%>&&statusbill=<%=status%>&&url=<%=pathName%>">update</a> </td>
                        <td><a href="ControllerProject?action=deletebilldetail&&oid=<%=rsbilldetail.getString("oid")%>&&pid=<%=rsbilldetail.getString("pid")%>&&statusbill=<%=status%>&&url=<%=pathName%>">delete</a> </td>
                    </tr>
                    <%}%>
                </tbody>
            </table>

        </form>
        <%}%>
    </body>

</html>
