<%-- 
    Document   : UpdateBillDetail
    Created on : Oct 25, 2021, 5:35:38 PM
    Author     : DELL
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% ResultSet rs = (ResultSet)request.getAttribute("rs");
            if(rs==null){
                out.println("no billdetail");
            }else{
            String urlJSP = (String) request.getAttribute("url");
            
        %>
        
        <form action="ControllerProject?action=updatebilldetail&&oid=<%=rs.getString("oid")%>&&pid=<%=rs.getString("pid")%>&&url=<%=urlJSP%>" method="POST">
            <table border="1">
                <tbody>
                    <tr>
                        <td>Quantity</td>
                        <td><input type="text" name="quantity" value="<%=rs.getInt("quantity")%>" /></td>
                    </tr>
                    <tr>
                        <td>Price</td>
                        <td><input type="text" name="price" value="<%=rs.getDouble("price")%>" /></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="submit" name="submit" /></td>
                        <td><input type="reset" value="reset" name="reset" /></td>
                    </tr>
                </tbody>
            </table>
                    
        </form>
        <%}%>
    </body>
</html>
