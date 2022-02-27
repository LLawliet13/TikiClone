<%-- 
    Document   : InsertCategory
    Created on : Oct 7, 2021, 12:42:31 AM
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
        <%Boolean isDispatched = (Boolean) request.getAttribute("isDispatched");
            if(isDispatched==null){
                isDispatched = false ;
            }
        
        %>
          <form action="<%=(isDispatched == true? "": "../")%>ControllerCategory?action=insert" method="POST">
            <table border="1">
               
                <tbody>
                    <tr>
                        <td>cate name </td>
                        <td><input type="text" name="catename" value="" /></td>
                    </tr>
                    <tr>
                        <td>status</td>
                        <td>enable<input type="radio" name="status" value="1" checked="checked" />disable<input type="radio" name="status" value="0" /></td>
                    </tr>
                     <tr>
                         <td><input type="submit" value="submit" name="submit" /></td>
                         <td><input type="reset" value="reset" name="reset" /></td>
                
                    </tr>
                    
                </tbody>
            </table>

        
        </form>
    </body>
</html>
