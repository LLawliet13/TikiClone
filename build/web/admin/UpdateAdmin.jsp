<%-- 
    Document   : UpdateAdmin
    Created on : Oct 7, 2021, 12:11:36 AM
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
        <%ResultSet rs = (ResultSet) request.getAttribute("rs");%>
        <%if(rs.next()){%>
        <form action=<%="ControllerAdmin?action=update&&adminid="+rs.getString("adminid")%> method="POST">
            <table border="0">

                <tbody>
                    <tr>
                        <td>old password</td>
                        <td><input type="password" name="enteredoldpassword" value="" /></td>
                    </tr>
                    <tr>
                        <td>new password</td>
                        <td><input type="password" name="newpassword" value="" /></td>
                    </tr>
                    <tr>
                       <td>confirm password</td>
                        <td><input type="password" name="renewpassword" value="" /></td>
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
