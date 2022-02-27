<%-- 
    Document   : AddToCart
    Created on : Oct 11, 2021, 2:10:20 PM
    Author     : DELL
--%>

<%@page import="entity.Product"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add To Cart</title>
    </head>
    <body>
       <%
	ResultSet product = (ResultSet)request.getAttribute("product"); 
        if(product==null){
            response.sendRedirect("Item_list.jsp");
        }
        else if(product.next()){
        String pid = product.getString("pid");
	Product value = (Product)session.getAttribute(pid);
    
	if(value==null){
            
                int quantity = product.getInt("quantity");
                double price = product.getDouble("price");
                String pname = product.getString("pname");
                Product newPro = new Product(pid, pname, "", "", 0, 1, price, 0);
		session.setAttribute(pid,newPro);
	}
	else{
		value.setQuantity(value.getQuantity()+1);
		session.setAttribute(pid,value);
	}
        
%>
<h2>Item <%=product.getString("pname")%> was added to the Shopping Cart</h2>

<h2><a href="ShowCartProject.jsp">Show Shopping Cart</h2>
<%}%>
    </body>
</html>
