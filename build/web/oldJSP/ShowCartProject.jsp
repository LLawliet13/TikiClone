<%-- 
    Document   : ShowCartProject
    Created on : Oct 20, 2021, 1:59:45 PM
    Author     : DELL
--%>

<%@page import="entity.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="../css/itemliststyle.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    </head>
    <body>
        <% String uri = request.getRequestURI();
            String pageName = uri.substring(uri.lastIndexOf("/") + 1);%>
        <h4>Shopping Cart Details</h4>
        
        <form action="ControllerProduct_Cart?action=update&&url=project/<%=pageName%>" id="myForm" method="POST">
            <table class="table">
                <thead class="thead-light">
                <th scope="col">Item ID</th>
                <th scope="col">Name</th>
                <th scope="col">Quantity</th>
                <th scope="col">Price</th>
                <th scope="col">Total</th>
                <th scope="col">Remove</th>
                </thead>
                <%  
                    

                    java.util.Enumeration all = session.getAttributeNames();
                    Double totalBill = 0.0;
                    while (all.hasMoreElements()) {
                        String pid = all.nextElement().toString();
                        if (pid.equals("user")) {
                            continue;
                        }
                        Product pro = (Product) session.getAttribute(pid);
                        
                        int cateID = pro.getCateID();
                        String pname = pro.getPname();
                        int quantity = pro.getQuantity();
                        double price = pro.getPrice();
                        double total = quantity * price;
                        totalBill += total;


                %>

                <tbody>

                    <tr><td><%=pid%></td>
                        <td><%= pname%></td>
                        <td><input type="text" name="quantity" value="<%=quantity%>" /><input type="hidden" name="pid" value="<%=pid%>" /></td>
                        <td><%= price%></td>
                        <td><%=total%></td>
                        <td><a href="../ControllerProduct_Cart?action=removeCart&&pid=<%=pro.getPid()%>&&url=project/<%=pageName%>">remove</a></td>

                    </tr>



                    <%}%>
                    <tr><td></td><td></td><td>Total</td><td></td><td><%=totalBill%></td><td><a href="../ControllerProduct_Cart?action=removeCart&&pid=all&&url=project/<%=pageName%>">remove All</a></td></tr>
                </tbody>
            </table>
            <input type="submit" value="submit" name="submit" />
        </form>
        <%
            if (!pageName.equals("CheckOut.jsp")) {%>
        <h5><a href="IndexProject.jsp">Items List</a></h5>
   
        <br>
        <h5><a href="../CheckOut.jsp">Check-out</a></h5>
        
        <%}%>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        
    </body>
</html>
