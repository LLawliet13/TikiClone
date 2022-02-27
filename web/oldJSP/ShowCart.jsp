<%-- 
    Document   : ShowCart
    Created on : Oct 11, 2021, 5:49:23 PM
    Author     : DELL
--%>

<%@page import="entity.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Shopping Cart Details</h1>
        <table width=50% border="1">
            <tr><td>Item ID</td><td>Name</td><td>Quantity</td><td>Price</td><td>Total</td><td>Remove</td></tr>
            <%  

                java.util.Enumeration all = session.getAttributeNames();
                Double totalBill = 0.0;
                while (all.hasMoreElements()) {
                    String pid = all.nextElement().toString();
                    if(pid.equals("user")){continue;}
                    Product pro = (Product) session.getAttribute(pid);
                    int cateID = pro.getCateID();
                    String pname = pro.getPname();
                    int quantity = pro.getQuantity();
                    double price = pro.getPrice();
                    double total = quantity * price;
                    totalBill+=total;


            %>

            <tr><td><%=cateID%></td><td><%= pname%></td><td><%=quantity%></td><td><%= price%></td><td><%=total%></td><td><a href=<%="ControllerProduct_Cart?action=removeCart&&pid=" + pro.getPid()%>>remove</a></td></tr>
            

            <%}%>
            <tr><td></td><td></td><td>Total</td><td></td><td><%=totalBill%></td><td><a href="ControllerProduct_Cart?action=removeCart&&pid=all">remove All</a></td></tr>
        </table>

        <h2><a href="ControllerProduct_Cart">Items List</a></h2>
        <br>
        <h2><a href="CheckOut.jsp">Check-out</h2>
    </body>
</html>
