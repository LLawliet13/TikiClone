<%-- 
    Document   : Category
    Created on : Oct 17, 2021, 9:07:54 PM
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
         <% //   ResultSet rs = (ResultSet) request.getAttribute("rs");%>
        <form action="ControllerCategory?action=search&&urlJSP=/Category.jsp" method="POST">
            <table border="1">
              
                <tbody>
                    <tr>
                        <td>cate name </td>
                        <td><input type="text" name="catename" value="" /></td>
                    </tr>
                    <tr>
                        <td>order by(name)</td>
                        <td>ASC<input type="radio" name="order" value="order by catename asc" checked="checked" />DESC<input type="radio" name="order" value="order by catename desc" /></td>
                    </tr>
                    <tr>
                       
                        <td><input type="submit" value="submit" name="submit" /></td>
                        <td><input type="reset" value="reset" name="reset" /></td>
                    </tr>
                </tbody>
            </table>

        </form>
        <jsp:include page="ViewCategory.jsp"></jsp:include>
    </body>
</html>
