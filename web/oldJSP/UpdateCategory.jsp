<%-- 
    Document   : UpdateCategory
    Created on : Oct 7, 2021, 12:43:24 AM
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
        <% ResultSet rs = (ResultSet)request.getAttribute("rs");%>
        <%if(rs.next()){%>
        <form action="<%="ControllerCategory?action=update&&cateid="+rs.getInt("cateid")%>" method="POST">
            <table border="1">
               
                <tbody>
                    <tr>
                        <td>cate name </td>
                        <td><input type="text" name="catename" value="<%=rs.getInt("cateid")%>" /></td>
                    </tr>
                    <tr>
                        <td>status</td>
                        <td>enable<input type="radio" name="status" value="1" <%=rs.getInt("status")==1?"checked":""%> />
                            disable<input type="radio" name="status" value="0" <%=rs.getInt("status")==0?"checked":""%> /></td>
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
